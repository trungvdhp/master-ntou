namespace SyntheticDatasetGeneration
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
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.nudWidth = new System.Windows.Forms.NumericUpDown();
            this.nudDimensions = new System.Windows.Forms.NumericUpDown();
            this.nudHeight = new System.Windows.Forms.NumericUpDown();
            this.label5 = new System.Windows.Forms.Label();
            this.nudMaximum = new System.Windows.Forms.NumericUpDown();
            this.label6 = new System.Windows.Forms.Label();
            this.nudMinimum = new System.Windows.Forms.NumericUpDown();
            this.panel1 = new System.Windows.Forms.Panel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.nudDecimalPlace = new System.Windows.Forms.NumericUpDown();
            this.label7 = new System.Windows.Forms.Label();
            this.btnGenerate = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.nudNumberOfClusters = new System.Windows.Forms.NumericUpDown();
            ((System.ComponentModel.ISupportInitialize)(this.nudWidth)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudDimensions)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudHeight)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudMaximum)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudMinimum)).BeginInit();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudDecimalPlace)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudNumberOfClusters)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(36, 27);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(70, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Image Width:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(36, 60);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(73, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Image Height:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(36, 93);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(96, 13);
            this.label3.TabIndex = 1;
            this.label3.Text = "Image Dimensions:";
            // 
            // nudWidth
            // 
            this.nudWidth.Increment = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.nudWidth.Location = new System.Drawing.Point(141, 25);
            this.nudWidth.Maximum = new decimal(new int[] {
            10000,
            0,
            0,
            0});
            this.nudWidth.Minimum = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.nudWidth.Name = "nudWidth";
            this.nudWidth.Size = new System.Drawing.Size(75, 20);
            this.nudWidth.TabIndex = 1;
            this.nudWidth.Value = new decimal(new int[] {
            960,
            0,
            0,
            0});
            // 
            // nudDimensions
            // 
            this.nudDimensions.Location = new System.Drawing.Point(141, 91);
            this.nudDimensions.Maximum = new decimal(new int[] {
            1000,
            0,
            0,
            0});
            this.nudDimensions.Minimum = new decimal(new int[] {
            3,
            0,
            0,
            0});
            this.nudDimensions.Name = "nudDimensions";
            this.nudDimensions.Size = new System.Drawing.Size(75, 20);
            this.nudDimensions.TabIndex = 3;
            this.nudDimensions.Value = new decimal(new int[] {
            3,
            0,
            0,
            0});
            // 
            // nudHeight
            // 
            this.nudHeight.Increment = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.nudHeight.Location = new System.Drawing.Point(141, 58);
            this.nudHeight.Maximum = new decimal(new int[] {
            10000,
            0,
            0,
            0});
            this.nudHeight.Minimum = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.nudHeight.Name = "nudHeight";
            this.nudHeight.Size = new System.Drawing.Size(75, 20);
            this.nudHeight.TabIndex = 2;
            this.nudHeight.Value = new decimal(new int[] {
            512,
            0,
            0,
            0});
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(22, 13);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(81, 13);
            this.label5.TabIndex = 1;
            this.label5.Text = "Minimum Value:";
            // 
            // nudMaximum
            // 
            this.nudMaximum.Location = new System.Drawing.Point(112, 45);
            this.nudMaximum.Maximum = new decimal(new int[] {
            1000000,
            0,
            0,
            0});
            this.nudMaximum.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.nudMaximum.Name = "nudMaximum";
            this.nudMaximum.Size = new System.Drawing.Size(87, 20);
            this.nudMaximum.TabIndex = 6;
            this.nudMaximum.Value = new decimal(new int[] {
            255,
            0,
            0,
            0});
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(22, 80);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(78, 13);
            this.label6.TabIndex = 1;
            this.label6.Text = "Decimal Place:";
            // 
            // nudMinimum
            // 
            this.nudMinimum.Location = new System.Drawing.Point(112, 11);
            this.nudMinimum.Maximum = new decimal(new int[] {
            1000000,
            0,
            0,
            0});
            this.nudMinimum.Minimum = new decimal(new int[] {
            1000000,
            0,
            0,
            -2147483648});
            this.nudMinimum.Name = "nudMinimum";
            this.nudMinimum.Size = new System.Drawing.Size(87, 20);
            this.nudMinimum.TabIndex = 5;
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel1.Controls.Add(this.nudNumberOfClusters);
            this.panel1.Controls.Add(this.label4);
            this.panel1.Location = new System.Drawing.Point(12, 12);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(228, 147);
            this.panel1.TabIndex = 4;
            // 
            // panel2
            // 
            this.panel2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel2.Controls.Add(this.nudMaximum);
            this.panel2.Controls.Add(this.nudDecimalPlace);
            this.panel2.Controls.Add(this.nudMinimum);
            this.panel2.Controls.Add(this.label7);
            this.panel2.Controls.Add(this.label6);
            this.panel2.Controls.Add(this.label5);
            this.panel2.Location = new System.Drawing.Point(246, 12);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(228, 114);
            this.panel2.TabIndex = 5;
            // 
            // nudDecimalPlace
            // 
            this.nudDecimalPlace.Location = new System.Drawing.Point(112, 78);
            this.nudDecimalPlace.Maximum = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.nudDecimalPlace.Name = "nudDecimalPlace";
            this.nudDecimalPlace.Size = new System.Drawing.Size(87, 20);
            this.nudDecimalPlace.TabIndex = 7;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(22, 47);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(84, 13);
            this.label7.TabIndex = 1;
            this.label7.Text = "Maximum Value:";
            // 
            // btnGenerate
            // 
            this.btnGenerate.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.btnGenerate.Location = new System.Drawing.Point(246, 132);
            this.btnGenerate.Name = "btnGenerate";
            this.btnGenerate.Size = new System.Drawing.Size(228, 27);
            this.btnGenerate.TabIndex = 8;
            this.btnGenerate.Text = "Generate";
            this.btnGenerate.UseVisualStyleBackColor = true;
            this.btnGenerate.Click += new System.EventHandler(this.btnGenerate_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(23, 113);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(99, 13);
            this.label4.TabIndex = 1;
            this.label4.Text = "Number of Clusters:";
            // 
            // nudNumberOfClusters
            // 
            this.nudNumberOfClusters.Location = new System.Drawing.Point(128, 111);
            this.nudNumberOfClusters.Maximum = new decimal(new int[] {
            1000,
            0,
            0,
            0});
            this.nudNumberOfClusters.Minimum = new decimal(new int[] {
            2,
            0,
            0,
            0});
            this.nudNumberOfClusters.Name = "nudNumberOfClusters";
            this.nudNumberOfClusters.Size = new System.Drawing.Size(75, 20);
            this.nudNumberOfClusters.TabIndex = 4;
            this.nudNumberOfClusters.Value = new decimal(new int[] {
            8,
            0,
            0,
            0});
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.Lavender;
            this.ClientSize = new System.Drawing.Size(488, 170);
            this.Controls.Add(this.btnGenerate);
            this.Controls.Add(this.nudHeight);
            this.Controls.Add(this.nudDimensions);
            this.Controls.Add(this.nudWidth);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.panel2);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Name = "frmMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Synthetic Image Segmentation Dataset Generation";
            ((System.ComponentModel.ISupportInitialize)(this.nudWidth)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudDimensions)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudHeight)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudMaximum)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudMinimum)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudDecimalPlace)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudNumberOfClusters)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.NumericUpDown nudWidth;
        private System.Windows.Forms.NumericUpDown nudDimensions;
        private System.Windows.Forms.NumericUpDown nudHeight;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.NumericUpDown nudMaximum;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.NumericUpDown nudMinimum;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.NumericUpDown nudDecimalPlace;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Button btnGenerate;
        private System.Windows.Forms.NumericUpDown nudNumberOfClusters;
        private System.Windows.Forms.Label label4;
    }
}

