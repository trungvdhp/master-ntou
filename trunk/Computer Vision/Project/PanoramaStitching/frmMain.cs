using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Emgu.CV;
using Emgu.Util;
using Emgu.CV.Util;
using Emgu.CV.Structure;
using Emgu.CV.Stitching;
using DirectShowLib;
using System.IO;
using System.Drawing.Imaging;

namespace PanoramaStitching
{
    public partial class frmMain : Form
    {
        Capture capture;
        Stitcher stitcher;
        IImage panorama;
        Image<Bgr, byte> defaultImage;
        List<Image<Bgr, byte>> images;
        List<Image<Bgr, byte>> inputImages;
        Video_Device[] WebCams;
        bool processing;
        int CameraDevice;
        int index;
        int totalTime;

        public frmMain()
        {
            InitializeComponent();
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            LoadCameraList();
            index = 0;
            totalTime = 0;
            defaultImage = new Image<Bgr, byte>(Properties.Resources.no_photo);
            images = new List<Image<Bgr, byte>>();
            ibxPanorama.Image = defaultImage;
        }

        private void LoadCameraList()
        {  
            // Find systems cameras with DirectShow.Net dll
            DsDevice[] _SystemCamereas = DsDevice.GetDevicesOfCat(FilterCategory.VideoInputDevice);
            WebCams = new Video_Device[_SystemCamereas.Length];

            for (int i = 0; i < _SystemCamereas.Length; i++)
            {
                // Fill web cam array
                WebCams[i] = new Video_Device(i, _SystemCamereas[i].Name, _SystemCamereas[i].ClassID);
                cboCamera.Items.Add(WebCams[i].ToString());
            }

            if (cboCamera.Items.Count > 0)
            {
                // Set the selected device the default
                cboCamera.SelectedIndex = 0;
                // Enable the start
                tblPictures.Enabled = true;
                
            }
            else
            {
                tblPictures.Enabled = false;
                timer1.Stop();
            }
        }

        private void CapturePicture()
        {
            try
            {
                index++;
                Bitmap img = capture.RetrieveBgrFrame().ToBitmap();
                images.Add(new Image<Bgr, byte>(img));
                lstPictures.Images.Add("P#" + index, img);
                lvwPictures.Items.Add("P#" + index, "Pic #" + index, index - 1);
                lvwPictures.Items[lvwPictures.Items.Count-1].Focused = true;
            }
            catch (System.Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnCapture_Click(object sender, EventArgs e)
        {
            if (chkAutoCapture.Checked)
            {
                btnCapture.Enabled = false;
                captureToolStripMenuItem.Enabled = false;
                btnBrowse.Enabled = false;
                browseToolStripMenuItem.Enabled = false;
                timer2.Interval = int.Parse(nudInterval.Value.ToString()) * 1000;
                timer2.Start();
            }
            else
            {
                CapturePicture();
            }
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            try
            {
                pbxRender.Image = capture.RetrieveBgrFrame().ToBitmap();
            }
            catch (System.Exception ex)
            {
                MessageBox.Show(ex.Message, "Camera Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }

        private void ChangeState()
        {
            foreach (Control c in pnlCommand.Controls)
            {
                c.Enabled = !processing;
            }

            lblTimer.Enabled = true;
            captureToolStripMenuItem.Enabled = !processing;
            browseToolStripMenuItem.Enabled = !processing;
            resetToolStripMenuItem.Enabled = !processing;

            btnStitch.Enabled = true;

            if (processing)
            {
                btnStitch.Text = "&Stop";
                stitchToolStripMenuItem.Text = "&Stop";
                stitcher = new Stitcher(false);
            }
            else
            {
                btnStitch.Text = "&Stitch";
                stitchToolStripMenuItem.Text = "&Stitch";
                stitcher.Dispose();
            }
        }

        private void btnStitch_Click(object sender, EventArgs e)
        {
            timer2.Stop();

            if (btnStitch.Text == "&Stitch")
            {
                processing = true;
                ChangeState();
                totalTime = 0;
                inputImages = new List<Image<Bgr, byte>>();

                foreach (ListViewItem item in lvwPictures.Items)
                {
                    inputImages.Add(images[item.ImageIndex]);
                }

                timer3.Start();
                bgwStitching.RunWorkerAsync();
            }
            else
            {
                processing = false;
                bgwStitching.CancelAsync();
            }
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            index = 0;
            timer2.Stop();
            images.Clear();
            lstPictures.Images.Clear();
            lvwPictures.Clear();
            ibxPanorama.Image = null;
            btnCapture.Enabled = true;
            captureToolStripMenuItem.Enabled = true;
            btnBrowse.Enabled = true;
            browseToolStripMenuItem.Enabled = true;
            ibxPanorama.Image = defaultImage;
        }

        private void timer2_Tick(object sender, EventArgs e)
        {
            if (chkAutoCapture.Checked)
            {
                CapturePicture();
            }
            else
            {
                btnCapture.Enabled = true;
                captureToolStripMenuItem.Enabled = true;
                btnBrowse.Enabled = true;
                browseToolStripMenuItem.Enabled = true;
            }
        }

        /// <summary>
        /// Sets up the _capture variable with the selected camera index
        /// </summary>
        /// <param name="Camera_Identifier"></param>
        private void SetupCapture(int Camera_Identifier)
        {
            //update the selected device
            CameraDevice = Camera_Identifier;

            //Dispose of Capture if it was created before
            if (capture != null) capture.Dispose();
            try
            {
                //Set up capture device
                capture = new Capture(CameraDevice);
                timer1.Start();
            }
            catch (NullReferenceException ex)
            {
                MessageBox.Show(ex.Message, "Setup Capture Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void cboCamera_SelectedIndexChanged(object sender, EventArgs e)
        {
            SetupCapture(cboCamera.SelectedIndex);
        }

        private void btnBrowse_Click(object sender, EventArgs e)
        {
            using (OpenFileDialog dlg = new OpenFileDialog())
            {
                dlg.Title = "Open Images";
                dlg.Filter = "Image files (*.jpg, *.jpeg, *.jpe, *.jfif, *.png) | *.jpg; *.jpeg; *.jpe; *.jfif; *.png";
                dlg.Multiselect = true;
                string initPath = Directory.GetCurrentDirectory() + @"\InputData";

                if (!Directory.Exists(initPath)) 
                    Directory.CreateDirectory(initPath);

                dlg.InitialDirectory = Path.GetFullPath(initPath);

                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    Bitmap img;

                    foreach (var fileName in dlg.FileNames)
                    {
                        index++;
                        img = new Bitmap(fileName);
                        images.Add(new Image<Bgr, byte>(img));
                        lstPictures.Images.Add("P#" + index, img);
                        lvwPictures.Items.Add("P#" + index, "Pic #" + index, index - 1);
                    }

                    lvwPictures.Items[index - 1].Focused = true;
                }
            }
        }

        private void bgwStitching_DoWork(object sender, DoWorkEventArgs e)
        {
            try
            {
                panorama = stitcher.Stitch(inputImages.ToArray());
            }
            catch (System.Exception ex)
            {
                MessageBox.Show(ex.Message, "Stitching Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                processing = false;
            }
        }

        private void bgwStitching_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            if (processing)
            {
                ibxPanorama.Image = panorama;
                processing = false;
            }
            else
            {
                ibxPanorama.Image = defaultImage;
            }

            timer3.Stop();
            ChangeState();
        }

        private void ChangeCameraSizeMode(PictureBoxSizeMode sizeMode)
        {
            pbxRender.SizeMode = sizeMode;

            foreach (ToolStripMenuItem Item in sizeModeToolStripMenuItem.DropDownItems)
            {
                Item.Checked = false;
            }
        }

        private void normalToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ChangeCameraSizeMode(PictureBoxSizeMode.Normal);
            normalToolStripMenuItem.Checked = true;
        }

        private void stretchImageToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ChangeCameraSizeMode(PictureBoxSizeMode.StretchImage);
            stretchImageToolStripMenuItem.Checked = true;
        }

        private void autoSizeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ChangeCameraSizeMode(PictureBoxSizeMode.AutoSize);
            autoSizeToolStripMenuItem.Checked = true;
        }

        private void centerImageToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ChangeCameraSizeMode(PictureBoxSizeMode.CenterImage);
            centerImageToolStripMenuItem.Checked = true;
        }

        private void zoomToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ChangeCameraSizeMode(PictureBoxSizeMode.Zoom);
            zoomToolStripMenuItem.Checked = true;
        }

        private void ChangeInputAlignment(ListViewAlignment align)
        {
            lvwPictures.Alignment = align;

            foreach (ToolStripMenuItem Item in alignmentToolStripMenuItem.DropDownItems)
            {
                Item.Checked = false;
            }
        }

        private void topToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ChangeInputAlignment(ListViewAlignment.Top);
            topToolStripMenuItem.Checked = true;
        }

        private void leftToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ChangeInputAlignment(ListViewAlignment.Left);
            leftToolStripMenuItem.Checked = true;
        }

        private void snapToGridToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ChangeInputAlignment(ListViewAlignment.SnapToGrid);
            snapToGridToolStripMenuItem.Checked = true;
        }

        [Description("Gets the total time in mm:ss format")]
        private string TotalTimeMMSS()
        {
            int mi = totalTime / 60;
            int se = totalTime % 60;
            return string.Format("{0:00}:{1:00}", mi, se);
        }

        private void timer3_Tick(object sender, EventArgs e)
        {
            totalTime++;
            lblTimer.Text = TotalTimeMMSS();
        }

        private void btnDeleteSelected_Click(object sender, EventArgs e)
        {
            var items = lvwPictures.SelectedItems;

            foreach (ListViewItem item in items)
            {
                lvwPictures.Items.Remove(item);
            }
        }

        private void btnSaveInputAs_Click(object sender, EventArgs e)
        {
            if (lvwPictures.Items.Count == 0)
            {
                MessageBox.Show("No input images", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            SaveFileDialog sfd = new SaveFileDialog();
            sfd.Filter = "Png Image|*.png|JPeg Image|*.jpg|Bitmap Image|*.bmp|Gif Image|*.gif";
            ImageFormat format = ImageFormat.Png;

            if (sfd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                string ext = System.IO.Path.GetExtension(sfd.FileName);

                switch (ext)
                {
                    case ".jpg":
                        format = ImageFormat.Jpeg;
                        break;
                    case ".bmp":
                        format = ImageFormat.Bmp;
                        break;
                    case ".gif":
                        format = ImageFormat.Gif;
                        break;
                }

                string path = sfd.FileName.Substring(0, sfd.FileName.LastIndexOf('.')) + "#";
                foreach (ListViewItem item in lvwPictures.Items)
                {
                    images[item.ImageIndex].ToBitmap().Save(path + item.ImageIndex + ext, format);
                }
            }
        }

        private void ChangeOutputSizeMode(PictureBoxSizeMode sizeMode)
        {
            ibxPanorama.SizeMode = sizeMode;

            foreach (ToolStripMenuItem Item in mnuOutput.Items)
            {
                Item.Checked = false;
            }
        }

        private void btnOutputSizeMode_Click(object sender, EventArgs e)
        {
            Button btnSender = (Button)sender;
            Point ptLowerLeft = new Point(0, btnSender.Height);
            ptLowerLeft = btnSender.PointToScreen(ptLowerLeft);
            mnuOutput.Show(ptLowerLeft);
        }

        private void normalToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            ChangeOutputSizeMode(PictureBoxSizeMode.Normal);
            normalToolStripMenuItem1.Checked = true;
        }

        private void stretchImageToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            ChangeOutputSizeMode(PictureBoxSizeMode.StretchImage);
            stretchImageToolStripMenuItem1.Checked = true;
        }

        private void autoSizeToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            ChangeOutputSizeMode(PictureBoxSizeMode.AutoSize);
            autoSizeToolStripMenuItem1.Checked = true;
        }

        private void centerImageToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            ChangeOutputSizeMode(PictureBoxSizeMode.CenterImage);
            centerImageToolStripMenuItem1.Checked = true;
        }

        private void zoomToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            ChangeOutputSizeMode(PictureBoxSizeMode.Zoom);
            zoomToolStripMenuItem1.Checked = true;
        }
    }
}
