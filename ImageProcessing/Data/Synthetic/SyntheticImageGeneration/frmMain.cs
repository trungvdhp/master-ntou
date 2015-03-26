using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SyntheticDatasetGeneration
{
    public partial class frmMain : Form
    {
        public frmMain()
        {
            InitializeComponent();
        }

        private void btnGenerate_Click(object sender, EventArgs e)
        {
            int width = Convert.ToInt32(nudWidth.Value);
            int height = Convert.ToInt32(nudHeight.Value);
            int dimensions = Convert.ToInt32(nudDimensions.Value);
            int numberOfClusters = Convert.ToInt32(nudNumberOfClusters.Value);
            int maximum = Convert.ToInt32(nudMaximum.Value);
            int minimum = Convert.ToInt32(nudMinimum.Value);
            int decimalPlace = Convert.ToInt32(nudDecimalPlace.Value);
            int numberOfDataPoints = width * height;
            int size = numberOfDataPoints * dimensions;
            int range = maximum - minimum;
            SaveFileDialog save = new SaveFileDialog();
            save.Title = "Save Synthetic Image Segmentation Dataset";
            save.FileName = width + "x" + height + "x" + dimensions + ".dat";

            if (save.ShowDialog() == DialogResult.OK)
            {
               
                double tmp;
                string value;
                Random rnd = new Random();

                using (System.IO.StreamWriter sw = new System.IO.StreamWriter(save.FileName))
                {
                    sw.Write(numberOfDataPoints + " " + numberOfClusters + " " + dimensions + " -1\r\n");

                    for (int i = 0; i < numberOfDataPoints; ++i)
                    {
                        for (int j = 0; j < dimensions; ++j)
                        {
                            tmp = rnd.NextDouble() * range + minimum;
                            value = tmp.ToString("F" + decimalPlace) + " ";
                            sw.Write(value);
                        }
                        sw.Write("\r\n");
                    }
                    sw.Close();
                }
            }
        }
    }
}
