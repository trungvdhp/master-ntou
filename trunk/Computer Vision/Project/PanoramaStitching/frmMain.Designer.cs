namespace PanoramaStitching
{
    partial class frmMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMain));
            this.pnlCommand = new System.Windows.Forms.Panel();
            this.lblTimer = new System.Windows.Forms.Label();
            this.cboCamera = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.nudInterval = new System.Windows.Forms.NumericUpDown();
            this.chkAutoCapture = new System.Windows.Forms.CheckBox();
            this.btnBrowse = new System.Windows.Forms.Button();
            this.btnReset = new System.Windows.Forms.Button();
            this.btnDeleteSelected = new System.Windows.Forms.Button();
            this.btnStitch = new System.Windows.Forms.Button();
            this.btnCapture = new System.Windows.Forms.Button();
            this.lstPictures = new System.Windows.Forms.ImageList(this.components);
            this.tblPictures = new System.Windows.Forms.TableLayoutPanel();
            this.pbxRender = new System.Windows.Forms.PictureBox();
            this.mnuCamera = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.captureToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.sizeModeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.normalToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.stretchImageToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.autoSizeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.centerImageToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.zoomToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.lvwPictures = new System.Windows.Forms.ListView();
            this.mnuInput = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.browseToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.resetToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.stitchToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.alignmentToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.topToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.leftToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.snapToGridToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.deleteSelectedToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.timer2 = new System.Windows.Forms.Timer(this.components);
            this.bgwStitching = new System.ComponentModel.BackgroundWorker();
            this.ibxPanorama = new Emgu.CV.UI.ImageBox();
            this.timer3 = new System.Windows.Forms.Timer(this.components);
            this.btnSaveInputAs = new System.Windows.Forms.Button();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.saveInputAsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuOutput = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.normalToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.stretchImageToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.autoSizeToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.centerImageToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.zoomToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.btnOutputSizeMode = new System.Windows.Forms.Button();
            this.pnlCommand.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudInterval)).BeginInit();
            this.tblPictures.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pbxRender)).BeginInit();
            this.mnuCamera.SuspendLayout();
            this.mnuInput.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ibxPanorama)).BeginInit();
            this.mnuOutput.SuspendLayout();
            this.SuspendLayout();
            // 
            // pnlCommand
            // 
            this.pnlCommand.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pnlCommand.Controls.Add(this.lblTimer);
            this.pnlCommand.Controls.Add(this.cboCamera);
            this.pnlCommand.Controls.Add(this.label1);
            this.pnlCommand.Controls.Add(this.nudInterval);
            this.pnlCommand.Controls.Add(this.chkAutoCapture);
            this.pnlCommand.Controls.Add(this.btnBrowse);
            this.pnlCommand.Controls.Add(this.btnReset);
            this.pnlCommand.Controls.Add(this.btnDeleteSelected);
            this.pnlCommand.Controls.Add(this.btnSaveInputAs);
            this.pnlCommand.Controls.Add(this.btnStitch);
            this.pnlCommand.Controls.Add(this.btnCapture);
            this.pnlCommand.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.pnlCommand.Location = new System.Drawing.Point(5, 407);
            this.pnlCommand.Name = "pnlCommand";
            this.pnlCommand.Padding = new System.Windows.Forms.Padding(5);
            this.pnlCommand.Size = new System.Drawing.Size(972, 43);
            this.pnlCommand.TabIndex = 1;
            // 
            // lblTimer
            // 
            this.lblTimer.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblTimer.AutoSize = true;
            this.lblTimer.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblTimer.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.lblTimer.ForeColor = System.Drawing.SystemColors.ControlText;
            this.lblTimer.Location = new System.Drawing.Point(925, 11);
            this.lblTimer.Name = "lblTimer";
            this.lblTimer.Size = new System.Drawing.Size(41, 18);
            this.lblTimer.TabIndex = 6;
            this.lblTimer.Text = "00:00";
            this.lblTimer.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // cboCamera
            // 
            this.cboCamera.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboCamera.FormattingEnabled = true;
            this.cboCamera.Location = new System.Drawing.Point(8, 10);
            this.cboCamera.Name = "cboCamera";
            this.cboCamera.Size = new System.Drawing.Size(211, 21);
            this.cboCamera.TabIndex = 5;
            this.cboCamera.SelectedIndexChanged += new System.EventHandler(this.cboCamera_SelectedIndexChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(391, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(47, 13);
            this.label1.TabIndex = 4;
            this.label1.Text = "seconds";
            // 
            // nudInterval
            // 
            this.nudInterval.Location = new System.Drawing.Point(336, 11);
            this.nudInterval.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.nudInterval.Name = "nudInterval";
            this.nudInterval.Size = new System.Drawing.Size(49, 20);
            this.nudInterval.TabIndex = 3;
            this.nudInterval.Value = new decimal(new int[] {
            2,
            0,
            0,
            0});
            // 
            // chkAutoCapture
            // 
            this.chkAutoCapture.AutoSize = true;
            this.chkAutoCapture.Location = new System.Drawing.Point(225, 12);
            this.chkAutoCapture.Name = "chkAutoCapture";
            this.chkAutoCapture.Size = new System.Drawing.Size(114, 17);
            this.chkAutoCapture.TabIndex = 2;
            this.chkAutoCapture.Text = "Auto capture each";
            this.chkAutoCapture.UseVisualStyleBackColor = true;
            // 
            // btnBrowse
            // 
            this.btnBrowse.Location = new System.Drawing.Point(520, 8);
            this.btnBrowse.Name = "btnBrowse";
            this.btnBrowse.Size = new System.Drawing.Size(70, 23);
            this.btnBrowse.TabIndex = 1;
            this.btnBrowse.Text = "&Br&owse...";
            this.btnBrowse.UseVisualStyleBackColor = true;
            this.btnBrowse.Click += new System.EventHandler(this.btnBrowse_Click);
            // 
            // btnReset
            // 
            this.btnReset.Location = new System.Drawing.Point(672, 8);
            this.btnReset.Name = "btnReset";
            this.btnReset.Size = new System.Drawing.Size(70, 23);
            this.btnReset.TabIndex = 1;
            this.btnReset.Text = "&Reset";
            this.btnReset.UseVisualStyleBackColor = true;
            this.btnReset.Click += new System.EventHandler(this.btnReset_Click);
            // 
            // btnDeleteSelected
            // 
            this.btnDeleteSelected.Location = new System.Drawing.Point(596, 8);
            this.btnDeleteSelected.Name = "btnDeleteSelected";
            this.btnDeleteSelected.Size = new System.Drawing.Size(70, 23);
            this.btnDeleteSelected.TabIndex = 1;
            this.btnDeleteSelected.Text = "&Delete";
            this.btnDeleteSelected.UseVisualStyleBackColor = true;
            this.btnDeleteSelected.Click += new System.EventHandler(this.btnDeleteSelected_Click);
            // 
            // btnStitch
            // 
            this.btnStitch.Location = new System.Drawing.Point(847, 8);
            this.btnStitch.Name = "btnStitch";
            this.btnStitch.Size = new System.Drawing.Size(70, 23);
            this.btnStitch.TabIndex = 1;
            this.btnStitch.Text = "&Stitch";
            this.btnStitch.UseVisualStyleBackColor = true;
            this.btnStitch.Click += new System.EventHandler(this.btnStitch_Click);
            // 
            // btnCapture
            // 
            this.btnCapture.Location = new System.Drawing.Point(444, 8);
            this.btnCapture.Name = "btnCapture";
            this.btnCapture.Size = new System.Drawing.Size(70, 23);
            this.btnCapture.TabIndex = 0;
            this.btnCapture.Text = "&Capture";
            this.btnCapture.UseVisualStyleBackColor = true;
            this.btnCapture.Click += new System.EventHandler(this.btnCapture_Click);
            // 
            // lstPictures
            // 
            this.lstPictures.ColorDepth = System.Windows.Forms.ColorDepth.Depth24Bit;
            this.lstPictures.ImageSize = new System.Drawing.Size(160, 120);
            this.lstPictures.TransparentColor = System.Drawing.Color.Transparent;
            // 
            // tblPictures
            // 
            this.tblPictures.ColumnCount = 2;
            this.tblPictures.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 20.1995F));
            this.tblPictures.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 79.8005F));
            this.tblPictures.Controls.Add(this.pbxRender, 0, 0);
            this.tblPictures.Controls.Add(this.lvwPictures, 1, 0);
            this.tblPictures.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.tblPictures.Location = new System.Drawing.Point(5, 242);
            this.tblPictures.Name = "tblPictures";
            this.tblPictures.RowCount = 1;
            this.tblPictures.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tblPictures.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tblPictures.Size = new System.Drawing.Size(972, 165);
            this.tblPictures.TabIndex = 2;
            // 
            // pbxRender
            // 
            this.pbxRender.ContextMenuStrip = this.mnuCamera;
            this.pbxRender.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pbxRender.Location = new System.Drawing.Point(0, 0);
            this.pbxRender.Margin = new System.Windows.Forms.Padding(0);
            this.pbxRender.Name = "pbxRender";
            this.pbxRender.Size = new System.Drawing.Size(196, 165);
            this.pbxRender.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pbxRender.TabIndex = 0;
            this.pbxRender.TabStop = false;
            // 
            // mnuCamera
            // 
            this.mnuCamera.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.captureToolStripMenuItem,
            this.sizeModeToolStripMenuItem});
            this.mnuCamera.Name = "mnuCamera";
            this.mnuCamera.Size = new System.Drawing.Size(155, 48);
            // 
            // captureToolStripMenuItem
            // 
            this.captureToolStripMenuItem.Name = "captureToolStripMenuItem";
            this.captureToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Alt | System.Windows.Forms.Keys.C)));
            this.captureToolStripMenuItem.Size = new System.Drawing.Size(154, 22);
            this.captureToolStripMenuItem.Text = "&Capture";
            this.captureToolStripMenuItem.Click += new System.EventHandler(this.btnCapture_Click);
            // 
            // sizeModeToolStripMenuItem
            // 
            this.sizeModeToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.normalToolStripMenuItem,
            this.stretchImageToolStripMenuItem,
            this.autoSizeToolStripMenuItem,
            this.centerImageToolStripMenuItem,
            this.zoomToolStripMenuItem});
            this.sizeModeToolStripMenuItem.Name = "sizeModeToolStripMenuItem";
            this.sizeModeToolStripMenuItem.Size = new System.Drawing.Size(154, 22);
            this.sizeModeToolStripMenuItem.Text = "Size Mode";
            // 
            // normalToolStripMenuItem
            // 
            this.normalToolStripMenuItem.Name = "normalToolStripMenuItem";
            this.normalToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.normalToolStripMenuItem.Text = "Normal";
            this.normalToolStripMenuItem.Click += new System.EventHandler(this.normalToolStripMenuItem_Click);
            // 
            // stretchImageToolStripMenuItem
            // 
            this.stretchImageToolStripMenuItem.Name = "stretchImageToolStripMenuItem";
            this.stretchImageToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.stretchImageToolStripMenuItem.Text = "Stretch Image";
            this.stretchImageToolStripMenuItem.Click += new System.EventHandler(this.stretchImageToolStripMenuItem_Click);
            // 
            // autoSizeToolStripMenuItem
            // 
            this.autoSizeToolStripMenuItem.Name = "autoSizeToolStripMenuItem";
            this.autoSizeToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.autoSizeToolStripMenuItem.Text = "Auto Size";
            this.autoSizeToolStripMenuItem.Click += new System.EventHandler(this.autoSizeToolStripMenuItem_Click);
            // 
            // centerImageToolStripMenuItem
            // 
            this.centerImageToolStripMenuItem.Name = "centerImageToolStripMenuItem";
            this.centerImageToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.centerImageToolStripMenuItem.Text = "Center Image";
            this.centerImageToolStripMenuItem.Click += new System.EventHandler(this.centerImageToolStripMenuItem_Click);
            // 
            // zoomToolStripMenuItem
            // 
            this.zoomToolStripMenuItem.Checked = true;
            this.zoomToolStripMenuItem.CheckState = System.Windows.Forms.CheckState.Checked;
            this.zoomToolStripMenuItem.Name = "zoomToolStripMenuItem";
            this.zoomToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.zoomToolStripMenuItem.Text = "Zoom";
            this.zoomToolStripMenuItem.Click += new System.EventHandler(this.zoomToolStripMenuItem_Click);
            // 
            // lvwPictures
            // 
            this.lvwPictures.Alignment = System.Windows.Forms.ListViewAlignment.Left;
            this.lvwPictures.ContextMenuStrip = this.mnuInput;
            this.lvwPictures.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lvwPictures.LargeImageList = this.lstPictures;
            this.lvwPictures.Location = new System.Drawing.Point(196, 0);
            this.lvwPictures.Margin = new System.Windows.Forms.Padding(0);
            this.lvwPictures.Name = "lvwPictures";
            this.lvwPictures.Size = new System.Drawing.Size(776, 165);
            this.lvwPictures.TabIndex = 1;
            this.lvwPictures.UseCompatibleStateImageBehavior = false;
            // 
            // mnuInput
            // 
            this.mnuInput.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.alignmentToolStripMenuItem,
            this.toolStripSeparator1,
            this.stitchToolStripMenuItem,
            this.toolStripSeparator3,
            this.browseToolStripMenuItem,
            this.deleteSelectedToolStripMenuItem,
            this.resetToolStripMenuItem,
            this.toolStripSeparator2,
            this.saveInputAsToolStripMenuItem});
            this.mnuInput.Name = "mnuInput";
            this.mnuInput.Size = new System.Drawing.Size(227, 154);
            // 
            // browseToolStripMenuItem
            // 
            this.browseToolStripMenuItem.Name = "browseToolStripMenuItem";
            this.browseToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.O)));
            this.browseToolStripMenuItem.Size = new System.Drawing.Size(226, 22);
            this.browseToolStripMenuItem.Text = "Br&owse...";
            this.browseToolStripMenuItem.Click += new System.EventHandler(this.btnBrowse_Click);
            // 
            // resetToolStripMenuItem
            // 
            this.resetToolStripMenuItem.Name = "resetToolStripMenuItem";
            this.resetToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.R)));
            this.resetToolStripMenuItem.Size = new System.Drawing.Size(226, 22);
            this.resetToolStripMenuItem.Text = "&Reset";
            this.resetToolStripMenuItem.Click += new System.EventHandler(this.btnReset_Click);
            // 
            // stitchToolStripMenuItem
            // 
            this.stitchToolStripMenuItem.Name = "stitchToolStripMenuItem";
            this.stitchToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)(((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.Alt) 
            | System.Windows.Forms.Keys.S)));
            this.stitchToolStripMenuItem.Size = new System.Drawing.Size(226, 22);
            this.stitchToolStripMenuItem.Text = "&Stitch";
            this.stitchToolStripMenuItem.Click += new System.EventHandler(this.btnStitch_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(223, 6);
            // 
            // alignmentToolStripMenuItem
            // 
            this.alignmentToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.topToolStripMenuItem,
            this.leftToolStripMenuItem,
            this.snapToGridToolStripMenuItem});
            this.alignmentToolStripMenuItem.Name = "alignmentToolStripMenuItem";
            this.alignmentToolStripMenuItem.Size = new System.Drawing.Size(226, 22);
            this.alignmentToolStripMenuItem.Text = "Alignment";
            // 
            // topToolStripMenuItem
            // 
            this.topToolStripMenuItem.Name = "topToolStripMenuItem";
            this.topToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.topToolStripMenuItem.Text = "Top";
            this.topToolStripMenuItem.Click += new System.EventHandler(this.topToolStripMenuItem_Click);
            // 
            // leftToolStripMenuItem
            // 
            this.leftToolStripMenuItem.Checked = true;
            this.leftToolStripMenuItem.CheckState = System.Windows.Forms.CheckState.Checked;
            this.leftToolStripMenuItem.Name = "leftToolStripMenuItem";
            this.leftToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.leftToolStripMenuItem.Text = "Left";
            this.leftToolStripMenuItem.Click += new System.EventHandler(this.leftToolStripMenuItem_Click);
            // 
            // snapToGridToolStripMenuItem
            // 
            this.snapToGridToolStripMenuItem.Name = "snapToGridToolStripMenuItem";
            this.snapToGridToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.snapToGridToolStripMenuItem.Text = "Snap To Grid";
            this.snapToGridToolStripMenuItem.Click += new System.EventHandler(this.snapToGridToolStripMenuItem_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(223, 6);
            // 
            // deleteSelectedToolStripMenuItem
            // 
            this.deleteSelectedToolStripMenuItem.Name = "deleteSelectedToolStripMenuItem";
            this.deleteSelectedToolStripMenuItem.ShortcutKeys = System.Windows.Forms.Keys.Delete;
            this.deleteSelectedToolStripMenuItem.Size = new System.Drawing.Size(226, 22);
            this.deleteSelectedToolStripMenuItem.Text = "&Delete selected";
            this.deleteSelectedToolStripMenuItem.Click += new System.EventHandler(this.btnDeleteSelected_Click);
            // 
            // timer1
            // 
            this.timer1.Interval = 50;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // timer2
            // 
            this.timer2.Tick += new System.EventHandler(this.timer2_Tick);
            // 
            // bgwStitching
            // 
            this.bgwStitching.WorkerSupportsCancellation = true;
            this.bgwStitching.DoWork += new System.ComponentModel.DoWorkEventHandler(this.bgwStitching_DoWork);
            this.bgwStitching.RunWorkerCompleted += new System.ComponentModel.RunWorkerCompletedEventHandler(this.bgwStitching_RunWorkerCompleted);
            // 
            // ibxPanorama
            // 
            this.ibxPanorama.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ibxPanorama.Location = new System.Drawing.Point(5, 5);
            this.ibxPanorama.Name = "ibxPanorama";
            this.ibxPanorama.Size = new System.Drawing.Size(972, 237);
            this.ibxPanorama.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.ibxPanorama.TabIndex = 2;
            this.ibxPanorama.TabStop = false;
            // 
            // timer3
            // 
            this.timer3.Interval = 1000;
            this.timer3.Tick += new System.EventHandler(this.timer3_Tick);
            // 
            // btnSaveInputAs
            // 
            this.btnSaveInputAs.Location = new System.Drawing.Point(748, 8);
            this.btnSaveInputAs.Name = "btnSaveInputAs";
            this.btnSaveInputAs.Size = new System.Drawing.Size(93, 23);
            this.btnSaveInputAs.TabIndex = 1;
            this.btnSaveInputAs.Text = "Save Input &As...";
            this.btnSaveInputAs.UseVisualStyleBackColor = true;
            this.btnSaveInputAs.Click += new System.EventHandler(this.btnSaveInputAs_Click);
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            this.toolStripSeparator3.Size = new System.Drawing.Size(223, 6);
            // 
            // saveInputAsToolStripMenuItem
            // 
            this.saveInputAsToolStripMenuItem.Name = "saveInputAsToolStripMenuItem";
            this.saveInputAsToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)(((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.Shift) 
            | System.Windows.Forms.Keys.S)));
            this.saveInputAsToolStripMenuItem.Size = new System.Drawing.Size(226, 22);
            this.saveInputAsToolStripMenuItem.Text = "Save Input &As...";
            this.saveInputAsToolStripMenuItem.Click += new System.EventHandler(this.btnSaveInputAs_Click);
            // 
            // mnuOutput
            // 
            this.mnuOutput.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.normalToolStripMenuItem1,
            this.stretchImageToolStripMenuItem1,
            this.autoSizeToolStripMenuItem1,
            this.centerImageToolStripMenuItem1,
            this.zoomToolStripMenuItem1});
            this.mnuOutput.Name = "mnuOutput";
            this.mnuOutput.Size = new System.Drawing.Size(148, 114);
            // 
            // normalToolStripMenuItem1
            // 
            this.normalToolStripMenuItem1.Name = "normalToolStripMenuItem1";
            this.normalToolStripMenuItem1.Size = new System.Drawing.Size(147, 22);
            this.normalToolStripMenuItem1.Text = "Normal";
            this.normalToolStripMenuItem1.Click += new System.EventHandler(this.normalToolStripMenuItem1_Click);
            // 
            // stretchImageToolStripMenuItem1
            // 
            this.stretchImageToolStripMenuItem1.Checked = true;
            this.stretchImageToolStripMenuItem1.CheckState = System.Windows.Forms.CheckState.Checked;
            this.stretchImageToolStripMenuItem1.Name = "stretchImageToolStripMenuItem1";
            this.stretchImageToolStripMenuItem1.Size = new System.Drawing.Size(147, 22);
            this.stretchImageToolStripMenuItem1.Text = "Stretch Image";
            this.stretchImageToolStripMenuItem1.Click += new System.EventHandler(this.stretchImageToolStripMenuItem1_Click);
            // 
            // autoSizeToolStripMenuItem1
            // 
            this.autoSizeToolStripMenuItem1.Name = "autoSizeToolStripMenuItem1";
            this.autoSizeToolStripMenuItem1.Size = new System.Drawing.Size(147, 22);
            this.autoSizeToolStripMenuItem1.Text = "Auto Size";
            this.autoSizeToolStripMenuItem1.Click += new System.EventHandler(this.autoSizeToolStripMenuItem1_Click);
            // 
            // centerImageToolStripMenuItem1
            // 
            this.centerImageToolStripMenuItem1.Name = "centerImageToolStripMenuItem1";
            this.centerImageToolStripMenuItem1.Size = new System.Drawing.Size(147, 22);
            this.centerImageToolStripMenuItem1.Text = "Center Image";
            this.centerImageToolStripMenuItem1.Click += new System.EventHandler(this.centerImageToolStripMenuItem1_Click);
            // 
            // zoomToolStripMenuItem1
            // 
            this.zoomToolStripMenuItem1.Name = "zoomToolStripMenuItem1";
            this.zoomToolStripMenuItem1.Size = new System.Drawing.Size(147, 22);
            this.zoomToolStripMenuItem1.Text = "Zoom";
            this.zoomToolStripMenuItem1.Click += new System.EventHandler(this.zoomToolStripMenuItem1_Click);
            // 
            // btnOutputSizeMode
            // 
            this.btnOutputSizeMode.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.btnOutputSizeMode.BackColor = System.Drawing.SystemColors.Control;
            this.btnOutputSizeMode.FlatAppearance.BorderSize = 0;
            this.btnOutputSizeMode.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.btnOutputSizeMode.Location = new System.Drawing.Point(510, -1);
            this.btnOutputSizeMode.Name = "btnOutputSizeMode";
            this.btnOutputSizeMode.Size = new System.Drawing.Size(20, 14);
            this.btnOutputSizeMode.TabIndex = 4;
            this.btnOutputSizeMode.UseVisualStyleBackColor = false;
            this.btnOutputSizeMode.Click += new System.EventHandler(this.btnOutputSizeMode_Click);
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(982, 455);
            this.Controls.Add(this.btnOutputSizeMode);
            this.Controls.Add(this.ibxPanorama);
            this.Controls.Add(this.tblPictures);
            this.Controls.Add(this.pnlCommand);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "frmMain";
            this.Padding = new System.Windows.Forms.Padding(5);
            this.Text = "Panoramic Image Stitcher";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.frmMain_Load);
            this.pnlCommand.ResumeLayout(false);
            this.pnlCommand.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudInterval)).EndInit();
            this.tblPictures.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pbxRender)).EndInit();
            this.mnuCamera.ResumeLayout(false);
            this.mnuInput.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ibxPanorama)).EndInit();
            this.mnuOutput.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pnlCommand;
        private System.Windows.Forms.ImageList lstPictures;
        private System.Windows.Forms.Button btnStitch;
        private System.Windows.Forms.Button btnCapture;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.NumericUpDown nudInterval;
        private System.Windows.Forms.CheckBox chkAutoCapture;
        private System.Windows.Forms.TableLayoutPanel tblPictures;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.PictureBox pbxRender;
        private System.Windows.Forms.ListView lvwPictures;
        private System.Windows.Forms.Timer timer2;
        private System.Windows.Forms.Button btnReset;
        private System.Windows.Forms.ComboBox cboCamera;
        private System.Windows.Forms.Button btnBrowse;
        private System.ComponentModel.BackgroundWorker bgwStitching;
        private System.Windows.Forms.ContextMenuStrip mnuCamera;
        private System.Windows.Forms.ToolStripMenuItem captureToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem sizeModeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem normalToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem stretchImageToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem autoSizeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem centerImageToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem zoomToolStripMenuItem;
        private Emgu.CV.UI.ImageBox ibxPanorama;
        private System.Windows.Forms.ContextMenuStrip mnuInput;
        private System.Windows.Forms.ToolStripMenuItem browseToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem resetToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem stitchToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem alignmentToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem topToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem leftToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem snapToGridToolStripMenuItem;
        private System.Windows.Forms.Label lblTimer;
        private System.Windows.Forms.Timer timer3;
        private System.Windows.Forms.Button btnDeleteSelected;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripMenuItem deleteSelectedToolStripMenuItem;
        private System.Windows.Forms.Button btnSaveInputAs;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
        private System.Windows.Forms.ToolStripMenuItem saveInputAsToolStripMenuItem;
        private System.Windows.Forms.ContextMenuStrip mnuOutput;
        private System.Windows.Forms.ToolStripMenuItem normalToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem stretchImageToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem autoSizeToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem centerImageToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem zoomToolStripMenuItem1;
        private System.Windows.Forms.Button btnOutputSizeMode;
    }
}

