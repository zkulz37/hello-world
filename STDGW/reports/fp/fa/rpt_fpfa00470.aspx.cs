using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class reports_fp_fa_rpt_fpfa00470 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ESysLib.SetUser("hr");
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string TemplateFile = "rpt_fpfa00470.xls";
        string TempFile = "../../../system/temp/rpt_fpfa00470_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        string p_project_pk = "";
        string p_date = "a";
        //string para = "'" + p_project_pk + "','" + p_date + "'";
        string para = "'" + p_date + "'";
        int l_seq = 0;
        Color color1 = ColorTranslator.FromHtml("#C0C0C0");
        DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_fpfa00470", para);
        double s_tot1 = 0;
        double s_tot2 = 0;
        double s_tot3 = 0;
        double s_tot4 = 0;
        double s_tot5 = 0;
        double s_tot6 = 0;
        double s_tot7 = 0;
        double s_tot8 = 0;
        double s_tot9 = 0;
        double s_tot10 = 0;
        double s_tot11 = 0;
        double s_tot12 = 0;
        double s_tot13 = 0;
        double s_tot14 = 0;

        double tot1 = 0;
        double tot2 = 0;
        double tot3 = 0;
        double tot4 = 0;
        double tot5 = 0;
        double tot6 = 0;
        double tot7 = 0;
        double tot8 = 0;
        double tot9 = 0;
        double tot10 = 0;
        double tot11 = 0;
        double tot12 = 0;
        double tot13 = 0;
        double tot14 = 0;


        for (int i = 0; i < dt.Rows.Count - 1; i++)
        {
            exSheet.Range["A6"].Rows.EntireRow.Insert();
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (i == 0)
            {
                if (dt.Rows[i]["att04"].ToString() != "")
                {
                    s_tot1 = s_tot1 + Convert.ToDouble(dt.Rows[i]["att04"].ToString());
                    tot1 = tot1 + Convert.ToDouble(dt.Rows[i]["att04"].ToString());
                    exSheet.Cells[5 + i, 4].Value = Convert.ToDouble(dt.Rows[i]["att04"].ToString());
                }
                if (dt.Rows[i]["att05"].ToString() != "")
                {
                    s_tot2 = s_tot2 + Convert.ToDouble(dt.Rows[i]["att05"].ToString());
                    tot2 = tot2 + Convert.ToDouble(dt.Rows[i]["att05"].ToString());
                    exSheet.Cells[5 + i, 5].Value = Convert.ToDouble(dt.Rows[i]["att05"].ToString());
                }
                if (dt.Rows[i]["att06"].ToString() != "")
                {
                    s_tot3 = s_tot3 + Convert.ToDouble(dt.Rows[i]["att06"].ToString());
                    tot3 = tot3 + Convert.ToDouble(dt.Rows[i]["att06"].ToString());
                    exSheet.Cells[5 + i, 6].Value = Convert.ToDouble(dt.Rows[i]["att06"].ToString());
                }
                if (dt.Rows[i]["att07"].ToString() != "")
                {
                    s_tot4 = s_tot4 + Convert.ToDouble(dt.Rows[i]["att07"].ToString());
                    tot4 = tot4 + Convert.ToDouble(dt.Rows[i]["att07"].ToString());
                    exSheet.Cells[5 + i, 7].Value = Convert.ToDouble(dt.Rows[i]["att07"].ToString());
                }
                if (dt.Rows[i]["att08"].ToString() != "")
                {
                    s_tot5 = s_tot5 + Convert.ToDouble(dt.Rows[i]["att08"].ToString());
                    tot5 = tot5 + Convert.ToDouble(dt.Rows[i]["att08"].ToString());
                    exSheet.Cells[5 + i, 8].Value = Convert.ToDouble(dt.Rows[i]["att08"].ToString());
                }
                if (dt.Rows[i]["att09"].ToString() != "")
                {
                    s_tot6 = s_tot6 + Convert.ToDouble(dt.Rows[i]["att09"].ToString());
                    tot6 = tot6 + Convert.ToDouble(dt.Rows[i]["att09"].ToString());
                    exSheet.Cells[5 + i, 9].Value = Convert.ToDouble(dt.Rows[i]["att09"].ToString());
                }
                if (dt.Rows[i]["att10"].ToString() != "")
                {
                    s_tot7 = s_tot7 + Convert.ToDouble(dt.Rows[i]["att10"].ToString());
                    tot7 = tot7 + Convert.ToDouble(dt.Rows[i]["att10"].ToString());
                    exSheet.Cells[5 + i, 10].Value = Convert.ToDouble(dt.Rows[i]["att10"].ToString());
                }
                if (dt.Rows[i]["att11"].ToString() != "")
                {
                    s_tot8 = s_tot8 + Convert.ToDouble(dt.Rows[i]["att11"].ToString());
                    tot8 = tot8 + Convert.ToDouble(dt.Rows[i]["att11"].ToString());
                    exSheet.Cells[5 + i, 11].Value = Convert.ToDouble(dt.Rows[i]["att11"].ToString());
                }
                if (dt.Rows[i]["att12"].ToString() != "")
                {
                    s_tot9 = s_tot9 + Convert.ToDouble(dt.Rows[i]["att12"].ToString());
                    tot9 = tot9 + Convert.ToDouble(dt.Rows[i]["att12"].ToString());
                    exSheet.Cells[5 + i, 12].Value = Convert.ToDouble(dt.Rows[i]["att12"].ToString());
                }
                if (dt.Rows[i]["att13"].ToString() != "")
                {
                    s_tot10 = s_tot10 + Convert.ToDouble(dt.Rows[i]["att13"].ToString());
                    tot10 = tot10 + Convert.ToDouble(dt.Rows[i]["att13"].ToString());
                    exSheet.Cells[5 + i, 13].Value = Convert.ToDouble(dt.Rows[i]["att13"].ToString());
                }
                if (dt.Rows[i]["att14"].ToString() != "")
                {
                    s_tot11 = s_tot11 + Convert.ToDouble(dt.Rows[i]["att14"].ToString());
                    tot11 = tot11 + Convert.ToDouble(dt.Rows[i]["att14"].ToString());
                    exSheet.Cells[5 + i, 14].Value = Convert.ToDouble(dt.Rows[i]["att14"].ToString());
                }
                if (dt.Rows[i]["att15"].ToString() != "")
                {
                    s_tot12 = s_tot12 + Convert.ToDouble(dt.Rows[i]["att15"].ToString());
                    tot12 = tot12 + Convert.ToDouble(dt.Rows[i]["att15"].ToString());
                    exSheet.Cells[5 + i, 15].Value = Convert.ToDouble(dt.Rows[i]["att15"].ToString());
                }
                if (dt.Rows[i]["att16"].ToString() != "")
                {
                    s_tot13 = s_tot13 + Convert.ToDouble(dt.Rows[i]["att16"].ToString());
                    tot13 = tot13 + Convert.ToDouble(dt.Rows[i]["att16"].ToString());
                    exSheet.Cells[5 + i, 16].Value = Convert.ToDouble(dt.Rows[i]["att16"].ToString());
                }
                if (dt.Rows[i]["att17"].ToString() != "")
                {
                    s_tot14 = s_tot14 + Convert.ToDouble(dt.Rows[i]["att17"].ToString());
                    tot14 = tot14 + Convert.ToDouble(dt.Rows[i]["att17"].ToString());
                    exSheet.Cells[5 + i, 17].Value = Convert.ToDouble(dt.Rows[i]["att17"].ToString());
                }

                exSheet.Cells[5 + i, 1].Value = dt.Rows[i]["att01"].ToString();
                exSheet.Cells[5 + i, 2].Value = dt.Rows[i]["att02"].ToString();
                exSheet.Cells[5 + i, 3].Value = dt.Rows[i]["att03"].ToString();
                
            }
            else if (dt.Rows[i]["att01"].ToString() == dt.Rows[i - 1]["att01"].ToString())
            {
                if (dt.Rows[i]["att04"].ToString() != "")
                {
                    s_tot1 = s_tot1 + Convert.ToDouble(dt.Rows[i]["att04"].ToString());
                    tot1 = tot1 + Convert.ToDouble(dt.Rows[i]["att04"].ToString());
                    exSheet.Cells[5 + i + l_seq, 4].Value = Convert.ToDouble(dt.Rows[i]["att04"].ToString());
                }
                if (dt.Rows[i]["att05"].ToString() != "")
                {
                    s_tot2 = s_tot2 + Convert.ToDouble(dt.Rows[i]["att05"].ToString());
                    tot2 = tot2 + Convert.ToDouble(dt.Rows[i]["att05"].ToString());
                    exSheet.Cells[5 + i + l_seq, 5].Value = Convert.ToDouble(dt.Rows[i]["att05"].ToString());
                }
                if (dt.Rows[i]["att06"].ToString() != "")
                {
                    s_tot3 = s_tot3 + Convert.ToDouble(dt.Rows[i]["att06"].ToString());
                    tot3 = tot3 + Convert.ToDouble(dt.Rows[i]["att06"].ToString());
                    exSheet.Cells[5 + i + l_seq, 6].Value = Convert.ToDouble(dt.Rows[i]["att06"].ToString());
                }
                if (dt.Rows[i]["att07"].ToString() != "")
                {
                    s_tot4 = s_tot4 + Convert.ToDouble(dt.Rows[i]["att07"].ToString());
                    tot4 = tot4 + Convert.ToDouble(dt.Rows[i]["att07"].ToString());
                    exSheet.Cells[5 + i + l_seq, 7].Value = Convert.ToDouble(dt.Rows[i]["att07"].ToString());
                }
                if (dt.Rows[i]["att08"].ToString() != "")
                {
                    s_tot5 = s_tot5 + Convert.ToDouble(dt.Rows[i]["att08"].ToString());
                    tot5 = tot5 + Convert.ToDouble(dt.Rows[i]["att08"].ToString());
                    exSheet.Cells[5 + i + l_seq, 8].Value = Convert.ToDouble(dt.Rows[i]["att08"].ToString());
                }
                if (dt.Rows[i]["att09"].ToString() != "")
                {
                    s_tot6 = s_tot6 + Convert.ToDouble(dt.Rows[i]["att09"].ToString());
                    tot6 = tot6 + Convert.ToDouble(dt.Rows[i]["att09"].ToString());
                    exSheet.Cells[5 + i + l_seq, 9].Value = Convert.ToDouble(dt.Rows[i]["att09"].ToString());
                }
                if (dt.Rows[i]["att10"].ToString() != "")
                {
                    s_tot7 = s_tot7 + Convert.ToDouble(dt.Rows[i]["att10"].ToString());
                    tot7 = tot7 + Convert.ToDouble(dt.Rows[i]["att10"].ToString());
                    exSheet.Cells[5 + i + l_seq, 10].Value = Convert.ToDouble(dt.Rows[i]["att10"].ToString());
                }
                if (dt.Rows[i]["att11"].ToString() != "")
                {
                    s_tot8 = s_tot8 + Convert.ToDouble(dt.Rows[i]["att11"].ToString());
                    tot8 = tot8 + Convert.ToDouble(dt.Rows[i]["att11"].ToString());
                    exSheet.Cells[5 + i + l_seq, 11].Value = Convert.ToDouble(dt.Rows[i]["att11"].ToString());
                }
                if (dt.Rows[i]["att12"].ToString() != "")
                {
                    s_tot9 = s_tot9 + Convert.ToDouble(dt.Rows[i]["att12"].ToString());
                    tot9 = tot9 + Convert.ToDouble(dt.Rows[i]["att12"].ToString());
                    exSheet.Cells[5 + i + l_seq, 12].Value = Convert.ToDouble(dt.Rows[i]["att12"].ToString());
                }
                if (dt.Rows[i]["att13"].ToString() != "")
                {
                    s_tot10 = s_tot10 + Convert.ToDouble(dt.Rows[i]["att13"].ToString());
                    tot10 = tot10 + Convert.ToDouble(dt.Rows[i]["att13"].ToString());
                    exSheet.Cells[5 + i + l_seq, 13].Value = Convert.ToDouble(dt.Rows[i]["att13"].ToString());
                }
                if (dt.Rows[i]["att14"].ToString() != "")
                {
                    s_tot11 = s_tot11 + Convert.ToDouble(dt.Rows[i]["att14"].ToString());
                    tot11 = tot11 + Convert.ToDouble(dt.Rows[i]["att14"].ToString());
                    exSheet.Cells[5 + i + l_seq, 14].Value = Convert.ToDouble(dt.Rows[i]["att14"].ToString());
                }
                if (dt.Rows[i]["att15"].ToString() != "")
                {
                    s_tot12 = s_tot12 + Convert.ToDouble(dt.Rows[i]["att15"].ToString());
                    tot12 = tot12 + Convert.ToDouble(dt.Rows[i]["att15"].ToString());
                    exSheet.Cells[5 + i + l_seq, 15].Value = Convert.ToDouble(dt.Rows[i]["att15"].ToString());
                }
                if (dt.Rows[i]["att16"].ToString() != "")
                {
                    s_tot13 = s_tot13 + Convert.ToDouble(dt.Rows[i]["att16"].ToString());
                    tot13 = tot13 + Convert.ToDouble(dt.Rows[i]["att16"].ToString());
                    exSheet.Cells[5 + i + l_seq, 16].Value = Convert.ToDouble(dt.Rows[i]["att16"].ToString());
                }
                if (dt.Rows[i]["att17"].ToString() != "")
                {
                    s_tot14 = s_tot14 + Convert.ToDouble(dt.Rows[i]["att17"].ToString());
                    tot14 = tot14 + Convert.ToDouble(dt.Rows[i]["att17"].ToString());
                    exSheet.Cells[5 + i + l_seq, 17].Value = Convert.ToDouble(dt.Rows[i]["att17"].ToString());
                }
                exSheet.Cells[5 + i + l_seq, 1].Value = dt.Rows[i]["att01"].ToString();
                exSheet.Cells[5 + i + l_seq, 2].Value = dt.Rows[i]["att02"].ToString();
                exSheet.Cells[5 + i + l_seq, 3].Value = dt.Rows[i]["att03"].ToString();

            }
            else if (dt.Rows[i]["att01"].ToString() != dt.Rows[i - 1]["att01"].ToString())
            {

                exSheet.Range[5 + i + l_seq, 1].Rows.EntireRow.Insert();
                exSheet.Cells[5 + i + l_seq, 1, 5 + i + l_seq, 2].Merge();
                exSheet.Cells[5 + i + l_seq, 1].Value = "S-Total";
                exSheet.Cells[5 + i + l_seq, 1, 5 + i + l_seq, 2].HorizontalAlignment = XlHAlign.xlHAlignCenter;
                exSheet.Cells[5 + i + l_seq, 1, 5 + i + l_seq, 17].Interior.Color = color1;
                exSheet.Cells[5 + i + l_seq, 4].Value = s_tot1;
                exSheet.Cells[5 + i + l_seq, 5].Value = s_tot2;
                exSheet.Cells[5 + i + l_seq, 6].Value = s_tot3;
                exSheet.Cells[5 + i + l_seq, 7].Value = s_tot4;
                exSheet.Cells[5 + i + l_seq, 8].Value = s_tot5;
                exSheet.Cells[5 + i + l_seq, 9].Value = s_tot6;
                exSheet.Cells[5 + i + l_seq, 10].Value = s_tot7;
                exSheet.Cells[5 + i + l_seq, 11].Value = s_tot8;
                exSheet.Cells[5 + i + l_seq, 12].Value = s_tot9;
                exSheet.Cells[5 + i + l_seq, 13].Value = s_tot10;
                exSheet.Cells[5 + i + l_seq, 14].Value = s_tot11;
                exSheet.Cells[5 + i + l_seq, 15].Value = s_tot12;
                exSheet.Cells[5 + i + l_seq, 16].Value = s_tot13;
                exSheet.Cells[5 + i + l_seq, 17].Value = s_tot14;
           

                l_seq = l_seq + 1;

                s_tot1 = 0;
                s_tot2 = 0;
                s_tot3 = 0;
                s_tot4 = 0;
                s_tot5 = 0;
                s_tot6 = 0;
                s_tot7 = 0;
                s_tot8 = 0;
                s_tot9 = 0;
                s_tot10 = 0;
                s_tot11 = 0;
                s_tot12 = 0;
                s_tot13 = 0;
                s_tot14 = 0;

                


                if (dt.Rows[i]["att04"].ToString() != "")
                {
                    s_tot1 = s_tot1 + Convert.ToDouble(dt.Rows[i]["att04"].ToString());
                    tot1 = tot1 + Convert.ToDouble(dt.Rows[i]["att04"].ToString());
                    exSheet.Cells[5 + i + l_seq, 4].Value = Convert.ToDouble(dt.Rows[i]["att04"].ToString());
                }
                if (dt.Rows[i]["att05"].ToString() != "")
                {
                    s_tot2 = s_tot2 + Convert.ToDouble(dt.Rows[i]["att05"].ToString());
                    tot2 = tot2 + Convert.ToDouble(dt.Rows[i]["att05"].ToString());
                    exSheet.Cells[5 + i + l_seq, 5].Value = Convert.ToDouble(dt.Rows[i]["att05"].ToString());
                }
                if (dt.Rows[i]["att06"].ToString() != "")
                {
                    s_tot3 = s_tot3 + Convert.ToDouble(dt.Rows[i]["att06"].ToString());
                    tot3 = tot3 + Convert.ToDouble(dt.Rows[i]["att06"].ToString());
                    exSheet.Cells[5 + i + l_seq, 6].Value = Convert.ToDouble(dt.Rows[i]["att06"].ToString());
                }
                if (dt.Rows[i]["att07"].ToString() != "")
                {
                    s_tot4 = s_tot4 + Convert.ToDouble(dt.Rows[i]["att07"].ToString());
                    tot4 = tot4 + Convert.ToDouble(dt.Rows[i]["att07"].ToString());
                    exSheet.Cells[5 + i + l_seq, 7].Value = Convert.ToDouble(dt.Rows[i]["att07"].ToString());
                }
                if (dt.Rows[i]["att08"].ToString() != "")
                {
                    s_tot5 = s_tot5 + Convert.ToDouble(dt.Rows[i]["att08"].ToString());
                    tot5 = tot5 + Convert.ToDouble(dt.Rows[i]["att08"].ToString());
                    exSheet.Cells[5 + i + l_seq, 8].Value = Convert.ToDouble(dt.Rows[i]["att08"].ToString());
                }
                if (dt.Rows[i]["att09"].ToString() != "")
                {
                    s_tot6 = s_tot6 + Convert.ToDouble(dt.Rows[i]["att09"].ToString());
                    tot6 = tot6 + Convert.ToDouble(dt.Rows[i]["att09"].ToString());
                    exSheet.Cells[5 + i + l_seq, 9].Value = Convert.ToDouble(dt.Rows[i]["att09"].ToString());
                }
                if (dt.Rows[i]["att10"].ToString() != "")
                {
                    s_tot7 = s_tot7 + Convert.ToDouble(dt.Rows[i]["att10"].ToString());
                    tot7 = tot7 + Convert.ToDouble(dt.Rows[i]["att10"].ToString());
                    exSheet.Cells[5 + i + l_seq, 10].Value = Convert.ToDouble(dt.Rows[i]["att10"].ToString());
                }
                if (dt.Rows[i]["att11"].ToString() != "")
                {
                    s_tot8 = s_tot8 + Convert.ToDouble(dt.Rows[i]["att11"].ToString());
                    tot8 = tot8 + Convert.ToDouble(dt.Rows[i]["att11"].ToString());
                    exSheet.Cells[5 + i + l_seq, 11].Value = Convert.ToDouble(dt.Rows[i]["att11"].ToString());
                }
                if (dt.Rows[i]["att12"].ToString() != "")
                {
                    s_tot9 = s_tot9 + Convert.ToDouble(dt.Rows[i]["att12"].ToString());
                    tot9 = tot9 + Convert.ToDouble(dt.Rows[i]["att12"].ToString());
                    exSheet.Cells[5 + i + l_seq, 12].Value = Convert.ToDouble(dt.Rows[i]["att12"].ToString());
                }
                if (dt.Rows[i]["att13"].ToString() != "")
                {
                    s_tot10 = s_tot10 + Convert.ToDouble(dt.Rows[i]["att13"].ToString());
                    tot10 = tot10 + Convert.ToDouble(dt.Rows[i]["att13"].ToString());
                    exSheet.Cells[5 + i + l_seq, 13].Value = Convert.ToDouble(dt.Rows[i]["att13"].ToString());
                }
                if (dt.Rows[i]["att14"].ToString() != "")
                {
                    s_tot11 = s_tot11 + Convert.ToDouble(dt.Rows[i]["att14"].ToString());
                    tot11 = tot11 + Convert.ToDouble(dt.Rows[i]["att14"].ToString());
                    exSheet.Cells[5 + i + l_seq, 14].Value = Convert.ToDouble(dt.Rows[i]["att14"].ToString());
                }
                if (dt.Rows[i]["att15"].ToString() != "")
                {
                    s_tot12 = s_tot12 + Convert.ToDouble(dt.Rows[i]["att15"].ToString());
                    tot12 = tot12 + Convert.ToDouble(dt.Rows[i]["att15"].ToString());
                    exSheet.Cells[5 + i + l_seq, 15].Value = Convert.ToDouble(dt.Rows[i]["att15"].ToString());
                }
                if (dt.Rows[i]["att16"].ToString() != "")
                {
                    s_tot13 = s_tot13 + Convert.ToDouble(dt.Rows[i]["att16"].ToString());
                    tot13 = tot13 + Convert.ToDouble(dt.Rows[i]["att16"].ToString());
                    exSheet.Cells[5 + i + l_seq, 16].Value = Convert.ToDouble(dt.Rows[i]["att16"].ToString());
                }
                if (dt.Rows[i]["att17"].ToString() != "")
                {
                    s_tot14 = s_tot14 + Convert.ToDouble(dt.Rows[i]["att17"].ToString());
                    tot14 = tot14 + Convert.ToDouble(dt.Rows[i]["att17"].ToString());
                    exSheet.Cells[5 + i + l_seq, 17].Value = Convert.ToDouble(dt.Rows[i]["att17"].ToString());
                }
                exSheet.Cells[5 + i + l_seq, 1].Value = dt.Rows[i]["att01"].ToString();
                exSheet.Cells[5 + i + l_seq, 2].Value = dt.Rows[i]["att02"].ToString();
                exSheet.Cells[5 + i + l_seq, 3].Value = dt.Rows[i]["att03"].ToString();
            }
            
        }

        exSheet.Cells[5 + dt.Rows.Count + l_seq, 4].Value = s_tot1;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 5].Value = s_tot2;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 6].Value = s_tot3;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 7].Value = s_tot4;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 8].Value = s_tot5;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 9].Value = s_tot6;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 10].Value = s_tot7;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 11].Value = s_tot8;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 12].Value = s_tot9;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 13].Value = s_tot10;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 14].Value = s_tot11;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 15].Value = s_tot12;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 16].Value = s_tot13;
        exSheet.Cells[5 + dt.Rows.Count + l_seq, 17].Value = s_tot14;

        exSheet.Cells[6 + dt.Rows.Count + l_seq, 4].Value = tot1;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 5].Value = tot2;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 6].Value = tot3;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 7].Value = tot4;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 8].Value = tot5;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 9].Value = tot6;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 10].Value = tot7;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 11].Value = tot8;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 12].Value = tot9;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 13].Value = tot10;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 14].Value = tot11;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 15].Value = tot12;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 16].Value = tot13;
        exSheet.Cells[6 + dt.Rows.Count + l_seq, 17].Value = tot14;
        
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }

        exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        //string pdfFilePath = TempFile.Replace(".xls", ".pdf");

        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        //System.IO.FileInfo file = new System.IO.FileInfo(pdfFilePath);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Response.ContentType = "application/pdf";
        //Send file string to client 
        Response.WriteFile(TempFile);
        //Response.WriteFile(pdfFilePath);
        //Stop execute  
        Response.End();
    }
}
