using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class reports_rpt_ephl00080_ST01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("SALE");
		
        string p_master_pk 		= Request["p_master_pk"];
			
		/****************************************************************/
        string TemplateFile = "rpt_ephl00080_ST01.xls";
        string TempFile = "../../../system/temp/rpt_ephl00080_ST01_" + Session["User_ID"].ToString() + ".xls";
		
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);		
		/****************************************************************/

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];				
		
        IRange range;

        //bind data to excel file
		
		string p_date  = Request["p_date"];
		string p_wh_pk = Request["p_wh_pk"];
         
        DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_ephl00080_ST01", "'" + p_date + "','" + p_wh_pk + "'");
		
		int 	pos 		  = 3;
		string  l_parent_code = "";
		
		for (int i = 0; i < dtDetail.Rows.Count ; i++)
        {
                exSheet.Cells[pos + i, 1].Value = i+1;
				
				if ( (l_parent_code != dtDetail.Rows[i]["parent_code"].ToString()) || dtDetail.Rows[i]["parent_code"].ToString() == "")
				{
					exSheet.Cells[pos + i, 4].Value = dtDetail.Rows[i]["parent_code"];
					exSheet.Cells[pos + i, 5].Value = dtDetail.Rows[i]["parent_name"];
					exSheet.Cells[pos + i,10].Value = dtDetail.Rows[i]["PARENT_QTY"];
				}
				//-------------------
                exSheet.Cells[pos + i, 2].Value = dtDetail.Rows[i]["wh_id"];
                exSheet.Cells[pos + i, 3].Value = dtDetail.Rows[i]["wh_name"];
                
                exSheet.Cells[pos + i, 6].Value = dtDetail.Rows[i]["seq"];
				exSheet.Cells[pos + i, 7].Value = dtDetail.Rows[i]["child_code"];
				exSheet.Cells[pos + i, 8].Value = dtDetail.Rows[i]["child_name"];
				exSheet.Cells[pos + i, 9].Value = dtDetail.Rows[i]["cons_qty"];
				
				exSheet.Cells[pos + i,11].Value = dtDetail.Rows[i]["stock_Qty"];

				l_parent_code = dtDetail.Rows[i]["parent_code"].ToString();
				
                exSheet.Range["A"+(pos + i+1)].Rows.EntireRow.Insert();
        }
		
		/**************************************************************/
		/**************************************************************/
		/**************************************************************/
		/**************************************************************/
		/**************************************************************/
		
		exSheet = exBook.Worksheets[2];				
	                 
        dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_ephl00080_ST01_1", "'" + p_date + "','" + p_wh_pk + "'");
		
		pos = 3;
		
		for (int i = 0; i < dtDetail.Rows.Count ; i++)
        {
                exSheet.Cells[pos + i, 1].Value = i+1;
				
                exSheet.Cells[pos + i, 2].Value = dtDetail.Rows[i]["wh_id"];
                exSheet.Cells[pos + i, 3].Value = dtDetail.Rows[i]["wh_name"];
                exSheet.Cells[pos + i, 4].Value = dtDetail.Rows[i]["child_code"];
                exSheet.Cells[pos + i, 5].Value = dtDetail.Rows[i]["child_name"];
                exSheet.Cells[pos + i, 6].Value = dtDetail.Rows[i]["stock_Qty"];
				
                exSheet.Range["A"+(pos + i+1)].Rows.EntireRow.Insert();
        }

		/**************************************************************/
		/**************************************************************/
		/**************************************************************/
		/**************************************************************/
		/**************************************************************/
		
		exSheet = exBook.Worksheets[3];				
	                 
        dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_ephl00080_ST01_2", "'" + p_date + "','" + p_wh_pk + "'");
		
		pos = 4;
		
		for (int i = 0; i < dtDetail.Rows.Count ; i++)
        {
                exSheet.Cells[pos + i, 1].Value = i+1;
				
                exSheet.Cells[pos + i, 2].Value = dtDetail.Rows[i]["imex_code"];
                exSheet.Cells[pos + i, 3].Value = dtDetail.Rows[i]["child_code"];
                exSheet.Cells[pos + i, 4].Value = dtDetail.Rows[i]["child_name"];
                exSheet.Cells[pos + i, 5].Value = dtDetail.Rows[i]["uom"];
				exSheet.Cells[pos + i, 6].Value = dtDetail.Rows[i]["stock_qty"];
                exSheet.Cells[pos + i, 7].Value = dtDetail.Rows[i]["dorco_mat"];
				exSheet.Cells[pos + i, 8].Value = dtDetail.Rows[i]["ks_mat"];
				exSheet.Cells[pos + i, 9].Value = dtDetail.Rows[i]["dorco_in_process"];
				exSheet.Cells[pos + i,10].Value = dtDetail.Rows[i]["ks_in_process"];
				exSheet.Cells[pos + i,11].Value = dtDetail.Rows[i]["prod"];
				
                exSheet.Range["A"+(pos + i+1)].Rows.EntireRow.Insert();
        }

		/**************************************************************/
		/**************************************************************/
		/**************************************************************/
		/**************************************************************/
		/**************************************************************/
		
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        //range = exSheet.Range["A1"];
        // hide row A5 
        // range.Rows.Hidden = true;

        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

        exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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
        //Response.WriteFile(pdfFilePath);
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();

    }

    public Bitmap ResizeImage(Bitmap d, int w, int h)
    {
        Bitmap q = new Bitmap(w, h);
        float f, g;
        f = (float)w / (float)d.Width;
        g = (float)h / (float)d.Height;
        for (int i = 0; i < w; i++)
        {
            for (int j = 0; j < h; j++)
            {
                Color c;
                c = d.GetPixel((int)(i / f), (int)(j / g));
                q.SetPixel(i, j, c);
            }
        }
        return q;
    }
}