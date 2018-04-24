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

public partial class rpt_fppr00080_02 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		
        string l_from_date = Request["p_from_date"];
        string l_to_date   = Request["p_to_date"];        

        string TemplateFile = "rpt_fppr00080_02.xls";
		
        string TempFile = "../../../system/temp/rpt_fppr00080_02_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        string l_parameter = "'" + l_from_date + "'";
		
        DataTable dtDetail = ESysLib.TableReadOpenCursor("LG_rpt_fppr00080_02_1", l_parameter);
		//DataTable dtMaster = ESysLib.TableReadOpenCursor("LG_rpt_fppr00080_02_2", l_parameter);

        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A5"].Rows.EntireRow.Insert();//insert row new of sheet

        }
		
		/*if ( dtDetail.Rows.Count > 0 )
		{
			exSheet.Cells["B4"].Value = dtMaster.Rows[0]["search_date"].ToString();  
		}
		
		//-----------------------
		exSheet.Cells["D4"].Value = DateTime.Now.ToString("HH:mm"); 
		*/
		
        // loop detail not percent
        for (int l_row = 0; l_row < dtDetail.Rows.Count; l_row++)
        {   
			exSheet.Cells[4 + l_row, 1].Value = dtDetail.Rows[l_row]["item_name"].ToString();        
            exSheet.Cells[4 + l_row, 3].Value = dtDetail.Rows[l_row]["line_name"].ToString(); 
			exSheet.Cells[4 + l_row, 4].Value = dtDetail.Rows[l_row]["work_shift"].ToString(); 		 
			exSheet.Cells[4 + l_row, 5].Value = dtDetail.Rows[l_row]["total_qty"]; 			 
			exSheet.Cells[4 + l_row, 6].Value = dtDetail.Rows[l_row]["day00_qty"]; 
			exSheet.Cells[4 + l_row, 7].Value = dtDetail.Rows[l_row]["day01_qty"]; 	
			exSheet.Cells[4 + l_row, 8].Value = dtDetail.Rows[l_row]["day02_qty"]; 
			exSheet.Cells[4 + l_row, 9].Value = dtDetail.Rows[l_row]["day03_qty"]; 
			exSheet.Cells[4 + l_row,10].Value = dtDetail.Rows[l_row]["day04_qty"]; 
			exSheet.Cells[4 + l_row,11].Value = dtDetail.Rows[l_row]["day05_qty"]; 
			exSheet.Cells[4 + l_row,12].Value = dtDetail.Rows[l_row]["day06_qty"]; 
			exSheet.Cells[4 + l_row,13].Value = dtDetail.Rows[l_row]["day07_qty"]; 
			exSheet.Cells[4 + l_row,14].Value = dtDetail.Rows[l_row]["day08_qty"]; 	
			exSheet.Cells[4 + l_row,15].Value = dtDetail.Rows[l_row]["day09_qty"]; 
			exSheet.Cells[4 + l_row,16].Value = dtDetail.Rows[l_row]["day10_qty"]; 
			exSheet.Cells[4 + l_row,17].Value = dtDetail.Rows[l_row]["day11_qty"]; 
			exSheet.Cells[4 + l_row,18].Value = dtDetail.Rows[l_row]["day12_qty"]; 
			exSheet.Cells[4 + l_row,19].Value = dtDetail.Rows[l_row]["day13_qty"]; 
			exSheet.Cells[4 + l_row,20].Value = dtDetail.Rows[l_row]["day14_qty"]; 
			exSheet.Cells[4 + l_row,21].Value = dtDetail.Rows[l_row]["day15_qty"]; 
			exSheet.Cells[4 + l_row,22].Value = dtDetail.Rows[l_row]["day16_qty"]; 	
			exSheet.Cells[4 + l_row,23].Value = dtDetail.Rows[l_row]["day17_qty"]; 
			exSheet.Cells[4 + l_row,24].Value = dtDetail.Rows[l_row]["day18_qty"]; 
			exSheet.Cells[4 + l_row,25].Value = dtDetail.Rows[l_row]["day19_qty"]; 
			exSheet.Cells[4 + l_row,26].Value = dtDetail.Rows[l_row]["day20_qty"]; 
			exSheet.Cells[4 + l_row,27].Value = dtDetail.Rows[l_row]["day21_qty"]; 
			exSheet.Cells[4 + l_row,28].Value = dtDetail.Rows[l_row]["day22_qty"]; 
			exSheet.Cells[4 + l_row,29].Value = dtDetail.Rows[l_row]["day23_qty"]; 
			exSheet.Cells[8 + l_row,30].Value = dtDetail.Rows[l_row]["day24_qty"]; 
			exSheet.Cells[8 + l_row,31].Value = dtDetail.Rows[l_row]["day25_qty"]; 
			exSheet.Cells[8 + l_row,32].Value = dtDetail.Rows[l_row]["day26_qty"]; 
			exSheet.Cells[4 + l_row,33].Value = dtDetail.Rows[l_row]["day27_qty"]; 
			exSheet.Cells[4 + l_row,34].Value = dtDetail.Rows[l_row]["day28_qty"]; 
			exSheet.Cells[4 + l_row,35].Value = dtDetail.Rows[l_row]["day29_qty"]; 
			exSheet.Cells[4 + l_row,36].Value = dtDetail.Rows[l_row]["day30_qty"]; 
			exSheet.Cells[4 + l_row,37].Value = dtDetail.Rows[l_row]["day31_qty"]; 			 
        }

        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }     

        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

        exBook.SaveAs(TempFile);
        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Send file string to client 
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();

    }
}
