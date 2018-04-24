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

public partial class rpt_bico00020_ST10 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());		

        string TemplateFile = "rpt_bico00020_ST10.xls";
        string TempFile = "../../../system/temp/rpt_bico00020_ST10_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		
		string p_process_date 	= Request.QueryString["p_process_date"];	
		 
        string para ;
				
		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_bico00020_ST10_1" , "'" + Session["User_ID"].ToString() + "'");	
		
		para = "'" + p_process_date + "'";	
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_bico00020_ST10_3" , para);	
	 
        // MASTER   

		//--set-----DataBind--in---Master---
        if (!string.IsNullOrEmpty(dtInfo.Rows[0]["pic"].ToString()))
        {
            exSheet.Cells[1, 1].Select();
            byte[] MyData = new byte[0];
            MyData = (byte[])dtInfo.Rows[0]["pic"];
            MemoryStream stream = new MemoryStream(MyData);

            Bitmap b = new Bitmap(stream);
            exSheet.Shapes.AddPicture(ResizeImage(b, 90, 59));
        }
		
		//-------------------------------		
		
		exSheet.Cells["B1"].Value = dtInfo.Rows[0]["partner_name"];
		exSheet.Cells["B2"].Value = dtInfo.Rows[0]["addr1"];
		exSheet.Cells["B3"].Value = "Tax Code: " + dtInfo.Rows[0]["tax_code"];
		
		exSheet.Cells["E1"].Value = "Tel: "      + dtInfo.Rows[0]["phone_no"];
		exSheet.Cells["E2"].Value = "Fax No: "   + dtInfo.Rows[0]["fax_no"]; 
		exSheet.Cells["E3"].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");		        
		//-------------------------------	
		
		// INSERT ROWS
		 
		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
						
		// SET DATA
		int pos = 7 ;
		int i   = 0  ;		 
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {														
			exSheet.Cells[ pos+i, 1].Value = dtDetail.Rows[i]["center_id"];
			exSheet.Cells[ pos+i, 2].Value = dtDetail.Rows[i]["center_name"];
			exSheet.Cells[ pos+i, 3].Value = dtDetail.Rows[i]["revenue_amount"];								 		
			exSheet.Cells[ pos+i, 4].Value = dtDetail.Rows[i]["meterial_amount"];		
			exSheet.Cells[ pos+i, 5].Value = dtDetail.Rows[i]["labour_amount"];			
			exSheet.Cells[ pos+i, 6].Value = dtDetail.Rows[i]["others_amount"];			
			exSheet.Cells[ pos+i, 7].Value = dtDetail.Rows[i]["income_amount"];
        }
		//---------
        
		int t = pos+i-1 ;
		
		exSheet.Cells[pos + i,  3].Value = "=sum(C7:C"+t+")";	
		exSheet.Cells[pos + i,  4].Value = "=sum(D7:D"+t+")";	
		exSheet.Cells[pos + i,  5].Value = "=sum(E7:E"+t+")";	
		exSheet.Cells[pos + i,  6].Value = "=sum(F7:F"+t+")";	
		exSheet.Cells[pos + i,  7].Value = "=sum(G7:G"+t+")";
		
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