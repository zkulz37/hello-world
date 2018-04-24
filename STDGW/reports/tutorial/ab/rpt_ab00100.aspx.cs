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

public partial class rpt_ab00100 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_ab00100.xls";
        string TempFile = "../../../system/temp/rpt_ab00100_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
	
		
			//string p_date_from = Request["p_date_from"]; 
			//string p_date_to = Request["p_date_to"];
			//string p_by = Request["p_by"];
			        
        //string para = "'" + p_date_from + "','" + p_date_to +"','" + p_by+ "'";
		string sql ="",l_sql="";
		sql = "select c.data as line_ngang from TCO_BPPHOTO c where c.del_if=0 and c.pk = 185";
		l_sql = "select c.data as line_cheo from TCO_BPPHOTO c where c.del_if=0 and c.pk = 186";
		DataTable dt,dtl;
		dt = ESysLib.TableReadOpen(sql);		
		dtl = ESysLib.TableReadOpen(l_sql);		
	
        // MASTER   

		
		
		// INSERT ROWS
		 
		//for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        //{
          //  exSheet.Range["A9"].Rows.EntireRow.Insert();//insert row new of sheet
        //}
						
		// SET DATA
		/*int pos = 8 ;
		int i   = 0  ;		  						
		for (i = 0; i < dt.Rows.Count; i++)
        {								
			//exSheet.Cells[pos + i, 1 ].Value = i+1;
			exSheet.Cells[pos + i, 1 ].Value = dt.Rows[i]["folio_no"];
			exSheet.Cells[pos + i, 2 ].Value = dt.Rows[i]["room_no"];
			exSheet.Cells[pos + i, 3 ].Value = dt.Rows[i]["last_name"];
			//exSheet.Cells[pos + i, 4 ].Value = dt.Rows[i]["first_name"];
			exSheet.Cells[pos + i, 4 ].Value = dt.Rows[i]["checkin_date"];
			exSheet.Cells[pos + i, 5 ].Value = dt.Rows[i]["checkout_date"];
			exSheet.Cells[pos + i, 6 ].Value = dt.Rows[i]["days"];
			exSheet.Cells[pos + i, 7 ].Value = dt.Rows[i]["room_type"]; 
			exSheet.Cells[pos + i, 8 ].Value = dt.Rows[i]["checkin_by"]; 
			exSheet.Cells[pos + i, 9 ].Value = dt.Rows[i]["checkin_time"]; 
			exSheet.Cells[pos + i, 10 ].Value = dt.Rows[i]["checkout_by"];
			exSheet.Cells[pos + i, 11 ].Value = dt.Rows[i]["checkout_time"];			
			exSheet.Cells[pos + i, 12 ].Value = dt.Rows[i]["rate_name"];
			exSheet.Cells[pos + i, 13 ].Value = dt.Rows[i]["pay_method"];
					
        }/**/
		//---------
		exSheet.Cells["B20"].Select();
		byte[] MyData = new byte[0];
		//exSheet.Cells["B19"].Value= (byte[])dt.Rows[0]["line_ngang"];
		MyData = (byte[])dt.Rows[0]["line_ngang"];
		MemoryStream stream = new MemoryStream(MyData);
		Bitmap b = new Bitmap(stream);
        exSheet.Shapes.AddPicture(ResizeImage(b, 262, 2));//Show picture Column Width + 12, Row height
		
		//exSheet.Range["C20:G28"].Select();
		exSheet.Range["C20"].Select();
		byte[] MyDt = new byte[0];
        MyDt = (byte[])dtl.Rows[0]["line_cheo"];
        MemoryStream stream3 = new MemoryStream(MyDt);
		Bitmap b2 = new Bitmap(stream3);
        exSheet.Shapes.AddPicture(ResizeImage(b2,371,234));//Show picture Column Width, Row height
		//exSheet.Range["C19:G28"].Value=dt.Rows[0]["line_cheo"];
		exSheet.Range["A35"].Select();		 					
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