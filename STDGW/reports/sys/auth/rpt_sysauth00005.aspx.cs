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

public partial class rpt_sysauth00005 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		
		//ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string TemplateFile = "rpt_sysauth00005.xls";
        string TempFile = "../../../system/temp/rpt_sysauth00005_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
	
			string p_dbuser = Request["p_dbuser"]; 
			string p_from_date = Request["p_from_date"]; 
			string p_to_date = Request["p_to_date"]; 
			string p_org = Request["p_org"]; 
			string p_user_id = Request["p_user_id"]; 
			string p_user_name = Request["p_user_name"]; 
			string p_success_yn = Request["p_success_yn"]; 
			
			
			        
        string para = "'" + p_dbuser + "','" + p_from_date + "','" + p_to_date + "','" + p_org + "','" + p_user_id + "','" + p_user_name + "','"+ p_success_yn +"'";		
		//string para = "'" + p_dbuser + "','" + p_from_date + "','" + p_to_date + "','" + p_org + "','" + p_user_id + "','" + p_user_name + "','"+ p_success_yn +"'";		
		// Response.Write("aa");
		// Response.End();
		DataTable dt = ESysLib.TableReadOpenCursor("rpt_es_sel_login_history" ,para);
		
		
		exSheet.Cells["B2"].Value = dt.Rows[0]["from_date"].ToString()+" ~ "+dt.Rows[0]["date_to"].ToString();
		//exSheet.Cells["C2"].Value = "~ "+dt.Rows[0]["date_to"].ToString();
		
		
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A5"].Rows.EntireRow.Insert();//insert row new of sheet
        }

        
		
		// INSERT ROWS
		 
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A5"].Rows.EntireRow.Insert();//insert row new of sheet
        }
						
		// SET DATA
		int pos = 4 ;
		int i   = 0  ;		  						
		for (i = 0; i < dt.Rows.Count; i++)
        {								
			exSheet.Cells[pos + i,1  ].Value = dt.Rows[i]["rownum"];
			exSheet.Cells[pos + i,2  ].Value = dt.Rows[i]["user_id"];
			exSheet.Cells[pos + i,3  ].Value = dt.Rows[i]["user_name"];
			exSheet.Cells[pos + i,4  ].Value = dt.Rows[i]["org_nm"];
			exSheet.Cells[pos + i,5  ].Value = dt.Rows[i]["user_ip"];
			exSheet.Cells[pos + i,6  ].Value = dt.Rows[i]["login_date"];
			exSheet.Cells[pos + i,7 ].Value = dt.Rows[i]["emp_id"];
			exSheet.Cells[pos + i,8  ].Value = dt.Rows[i]["status"];
			exSheet.Cells[pos + i,9  ].Value = dt.Rows[i]["resign_date"];
			exSheet.Cells[pos + i,10  ].Value = dt.Rows[i]["sucess_yn"];
		}
		//---------
		//exSheet.Cells[pos + i, 6 ].Value = "=sum(F10:F"+(pos+i-1)+")";
		//exSheet.Cells[pos + i, 7].Value = "=sum(G10:G"+(pos+i-1)+")";			 					
		//---------
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        // hide row firts 
        range = exSheet.Range["A1"];
        // hide row A5 
        // range.Rows.Hidden = true;
        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

        exBook.SaveAs(TempFile);
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