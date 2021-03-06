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

public partial class reports_rpt_fpfa00430 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ESysLib.SetUser("hr");
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_project_pk,p_date;
        p_project_pk = Request["p_project_pk"].ToString();
        p_date = Request["p_date"].ToString();
        

        string TemplateFile = "rpt_fpfa00430.xls";
        string TempFile = "../../../system/temp/rpt_fpfa00430_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        
        IRange range;

        string para = "'" + p_project_pk + "','" + p_date + "'";
        DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_fpfa00430", para);

        if (dt.Rows.Count == 0)
        {
            Response.Write("There is no data.");
            Response.End();
        }


        //bind data to excel file
        int [] arr_cols = new int [100];
        int l_index = 0, l_count = 0, l_pos = 17;
        string s_temp = "";
        //-----header---   
        exSheet.Cells[1, 1].Select();
        exSheet.Cells["B3"].Value = dt.Rows[0]["pl_name"].ToString();
        exSheet.Cells["B6"].Value = dt.Rows[0]["report_dt"].ToString();      

        for (int i = 0; i < dt.Rows.Count - 1; i++)
        {
            if (i == 0)
            {
                l_count = 1;
                s_temp = dt.Rows[i]["ZONE"].ToString();
            }
            else
            {
                if (s_temp != dt.Rows[i]["ZONE"].ToString())
                {
                    arr_cols[l_index] = l_count;
                    l_count = 0;
                    l_index++;
                    s_temp = dt.Rows[i]["ZONE"].ToString();
                }
                else
                {
                    l_count++;
                }
            }
                    
        }
        arr_cols[l_index] = l_count;
        s_temp = "";
        l_index = 0;
        //Insert new row

        for ( int i = 0; i < dt.Rows.Count - 1 ; i++)
       {
           exSheet.Range[l_pos+1, 1].Rows.EntireRow.Insert();
       }

        //Show data
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            exSheet.Cells[l_pos + i, 1].Value =  dt.Rows[i]["ZONE"].ToString();
            exSheet.Cells[l_pos + i, 2].Value =  dt.Rows[i]["process"].ToString();
            exSheet.Cells[l_pos + i, 3].Value = Double.Parse(dt.Rows[i]["plan_qty"].ToString());
            exSheet.Cells[l_pos + i, 4].Value = Double.Parse(dt.Rows[i]["weight"].ToString());
            exSheet.Cells[l_pos + i, 5].Value = Double.Parse(dt.Rows[i]["accum_qty"].ToString());
            exSheet.Cells[l_pos + i, 6].Value = Double.Parse(dt.Rows[i]["accum_wgt"].ToString());
            exSheet.Cells[l_pos + i, 7].Value = Double.Parse(dt.Rows[i]["today_qty"].ToString());
            exSheet.Cells[l_pos + i, 8].Value = Double.Parse(dt.Rows[i]["today_wgt"].ToString());
            exSheet.Cells[l_pos + i, 9].Value = Double.Parse(dt.Rows[i]["sum_qty"].ToString());
            exSheet.Cells[l_pos + i, 10].Value = Double.Parse(dt.Rows[i]["sum_wgt"].ToString());
            exSheet.Cells[l_pos + i, 11].Value = Double.Parse(dt.Rows[i]["sum_wgt"].ToString()) / Double.Parse(dt.Rows[i]["weight"].ToString());           
            exSheet.Cells[l_pos + i, 12].Value = dt.Rows[i]["remarks"].ToString();  
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (s_temp != dt.Rows[i]["ZONE"].ToString())
            {

                exSheet.Cells[l_pos + i, 1, l_pos + i + arr_cols[l_index], 1].Merge();
                l_index++;
                s_temp = dt.Rows[i]["ZONE"].ToString();
            }
        }
        // end loop detail percent
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