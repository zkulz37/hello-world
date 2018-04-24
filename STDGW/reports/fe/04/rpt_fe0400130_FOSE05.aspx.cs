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

public partial class rpt_fe0400130_FOSE05 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_fe0400130_FOSE05.xls";
        string TempFile = "../../../system/temp/rpt_fe0400130_FOSE05_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		IWorkbook exBook_1 = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		IWorkbook exBook_2 = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		IWorkbook exBook_3 = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		IWorkbook exBook_4 = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		IWorkbook exBook_5 = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
		IWorksheet exSheet_1 = exBook.Worksheets[2];
		IWorksheet exSheet_2 = exBook.Worksheets[3];
		IWorksheet exSheet_3 = exBook.Worksheets[4];
		IWorksheet exSheet_4 = exBook.Worksheets[5];
		IWorksheet exSheet_5 = exBook.Worksheets[6];
        IRange range;

        //bind data to excel file
		 
        string wh_type , wh_pk , from_dt , to_dt , chk_amount, chk_act ;
        
		wh_type 	= Request.QueryString["wh_type"];
		wh_pk 		= Request.QueryString["wh_pk"];
		from_dt 	= Request.QueryString["from_dt"];
		to_dt 		= Request.QueryString["to_dt"];
         
        string para = "'" + wh_type + "','" + wh_pk + "','" + from_dt + "','" + to_dt + "'";	

		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_fe0400130_FOSE05_1", "'" + Session["User_ID"].ToString() + "'");				
			
        // MASTER   

		//--set-----DataBind--in---Master---
        if (!string.IsNullOrEmpty(dtInfo.Rows[0]["pic"].ToString()))
        {
            exSheet.Cells[1, 1].Select();
            byte[] MyData = new byte[0];
            MyData = (byte[])dtInfo.Rows[0]["pic"];
            MemoryStream stream = new MemoryStream(MyData);

            Bitmap b = new Bitmap(stream);
            exSheet.Shapes.AddPicture(ResizeImage(b, 90, 50));
			//---------------sheet 2-----------------
			exSheet_1.Cells[1, 1].Select();
            exSheet_1.Shapes.AddPicture(ResizeImage(b, 90, 50));
			//---------------sheet 3-----------------
			exSheet_2.Cells[1, 1].Select();
            exSheet_2.Shapes.AddPicture(ResizeImage(b, 90, 50));
			//---------------sheet 4-----------------
			exSheet_3.Cells[1, 1].Select();
            exSheet_3.Shapes.AddPicture(ResizeImage(b, 90, 50));
			//---------------sheet 5-----------------
			exSheet_4.Cells[1, 1].Select();
            exSheet_4.Shapes.AddPicture(ResizeImage(b, 90, 50));
			//---------------sheet 6-----------------
			exSheet_5.Cells[1, 1].Select();
            exSheet_5.Shapes.AddPicture(ResizeImage(b, 90, 50));
        }
		
		//--------------Sheet 1-----------------		
		exSheet.Cells["C1"].Value = dtInfo.Rows[0]["partner_name"];
		exSheet.Cells["C2"].Value = dtInfo.Rows[0]["addr1"];
		exSheet.Cells["C3"].Value = "Tax Code: " + dtInfo.Rows[0]["tax_code"];
		
		exSheet.Cells["G1"].Value = "Tel: "      + dtInfo.Rows[0]["phone_no"];
		exSheet.Cells["G2"].Value = "Fax No: "   + dtInfo.Rows[0]["fax_no"]; 
		exSheet.Cells["G3"].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");		  
		//---------------Sheet 2----------------		
		exSheet.Range["A1:K3"].Copy(exSheet_1.Range["A1:K3"], XlPasteType.xlPasteAll);       
		//---------------Sheet 3----------------		
		exSheet.Range["A1:K3"].Copy(exSheet_2.Range["A1:K3"], XlPasteType.xlPasteAll);  
		//---------------Sheet 4----------------		
		exSheet.Range["A1:K3"].Copy(exSheet_3.Range["A1:K3"], XlPasteType.xlPasteAll);    
		//---------------Sheet 5----------------		
		exSheet.Range["A1:K3"].Copy(exSheet_4.Range["A1:K3"], XlPasteType.xlPasteAll);    		
		//---------------Sheet 6----------------		
		exSheet.Range["A1:K3"].Copy(exSheet_5.Range["A1:K3"], XlPasteType.xlPasteAll);    
		//-------------------------------	
		//tong tin master
			
		// SET DATA
		int pos = 7 ;
		int i   = 0  ;		  						
		
		//------------------Sheet 1--------------------------
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fe0400130_FOSE05_2" , para);

		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet.Cells[pos + i, 1 ].Value = i+1;
			for (int j=2;j<=16;j++)
			{
				exSheet.Cells[pos + i, j ].Value = dtDetail.Rows[i][j-2];
			}
			
        }
		//---------
			exSheet.Cells[pos + i, 3 ].Value = "=SUM(C7:C"+(pos+i-1)+")";
			exSheet.Cells[pos + i, 4 ].Value = "=SUM(D7:D"+(pos+i-1)+")";			
			exSheet.Cells[pos + i, 5 ].Value = "=SUM(E7:E"+(pos+i-1)+")";
			exSheet.Cells[pos + i, 7 ].Value = "=SUM(G7:G"+(pos+i-1)+")";
			exSheet.Cells[pos + i, 9 ].Value = "=SUM(I7:I"+(pos+i-1)+")";				
			exSheet.Cells[pos + i, 11 ].Value = "=SUM(K7:K"+(pos+i-1)+")";	
			exSheet.Cells[pos + i, 13 ].Value = "=SUM(M7:M"+(pos+i-1)+")";	
			exSheet.Cells[pos + i, 15 ].Value = "=SUM(O7:O"+(pos+i-1)+")";	
			
				 		
		
		//------------------Sheet 2--------------------------
		dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fe0400130_FOSE05_3" , para);

		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet_1.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet_1.Cells[pos + i, 1 ].Value = i+1;
			for (int j=2;j<=16;j++)
			{
				exSheet_1.Cells[pos + i, j ].Value = dtDetail.Rows[i][j-2];
			}
			
        }
		//---------
			exSheet_1.Cells[pos + i, 3 ].Value = "=SUM(C7:C"+(pos+i-1)+")";
			exSheet_1.Cells[pos + i, 4 ].Value = "=SUM(D7:D"+(pos+i-1)+")";			
			exSheet_1.Cells[pos + i, 5 ].Value = "=SUM(E7:E"+(pos+i-1)+")";
			exSheet_1.Cells[pos + i, 7 ].Value = "=SUM(G7:G"+(pos+i-1)+")";
			exSheet_1.Cells[pos + i, 9 ].Value = "=SUM(I7:I"+(pos+i-1)+")";				
			exSheet_1.Cells[pos + i, 11 ].Value = "=SUM(K7:K"+(pos+i-1)+")";	
			exSheet_1.Cells[pos + i, 13 ].Value = "=SUM(M7:M"+(pos+i-1)+")";	
			exSheet_1.Cells[pos + i, 15 ].Value = "=SUM(O7:O"+(pos+i-1)+")";	
		//------------------Sheet 3--------------------------
		dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fe0400130_FOSE05_4" , para);

		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet_2.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet_2.Cells[pos + i, 1 ].Value = i+1;
			for (int j=2;j<dtDetail.Columns.Count+2;j++)
			{
				exSheet_2.Cells[pos + i, j ].Value = dtDetail.Rows[i][j-2];
			}
			
        }
		//---------
			exSheet_2.Cells[pos + i, 3 ].Value = "=SUM(C7:C"+(pos+i-1)+")";
			exSheet_2.Cells[pos + i, 4 ].Value = "=SUM(D7:D"+(pos+i-1)+")";			
			exSheet_2.Cells[pos + i, 5 ].Value = "=SUM(E7:E"+(pos+i-1)+")";
			exSheet_2.Cells[pos + i, 6 ].Value = "=SUM(F7:F"+(pos+i-1)+")";
			exSheet_2.Cells[pos + i, 7 ].Value = "=SUM(G7:G"+(pos+i-1)+")";				
			exSheet_2.Cells[pos + i, 8 ].Value = "=SUM(H7:H"+(pos+i-1)+")";	
			exSheet_2.Cells[pos + i, 9 ].Value = "=SUM(I7:I"+(pos+i-1)+")";	
			exSheet_2.Cells[pos + i, 10 ].Value = "=SUM(J7:J"+(pos+i-1)+")";
			exSheet_2.Cells[pos + i, 11 ].Value = "=SUM(K7:K"+(pos+i-1)+")";
			exSheet_2.Cells[pos + i, 12 ].Value = "=SUM(L7:L"+(pos+i-1)+")";			
			exSheet_2.Cells[pos + i, 13 ].Value = "=SUM(M7:M"+(pos+i-1)+")";

		//------------------Sheet 4--------------------------
		dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fe0400130_FOSE05_5" , para);

		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet_3.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet_3.Cells[pos + i, 1 ].Value = i+1;
			for (int j=2;j<dtDetail.Columns.Count+2;j++)
			{
				exSheet_3.Cells[pos + i, j ].Value = dtDetail.Rows[i][j-2];
			}
			
        }
		//---------
			exSheet_3.Cells[pos + i, 3 ].Value = "=SUM(C7:C"+(pos+i-1)+")";
			exSheet_3.Cells[pos + i, 4 ].Value = "=SUM(D7:D"+(pos+i-1)+")";			
			exSheet_3.Cells[pos + i, 5 ].Value = "=SUM(E7:E"+(pos+i-1)+")";
			exSheet_3.Cells[pos + i, 6 ].Value = "=SUM(F7:F"+(pos+i-1)+")";
			exSheet_3.Cells[pos + i, 7 ].Value = "=SUM(G7:G"+(pos+i-1)+")";				
			exSheet_3.Cells[pos + i, 8 ].Value = "=SUM(H7:H"+(pos+i-1)+")";	
			exSheet_3.Cells[pos + i, 9 ].Value = "=SUM(I7:I"+(pos+i-1)+")";	
			exSheet_3.Cells[pos + i, 10 ].Value = "=SUM(J7:J"+(pos+i-1)+")";
			exSheet_3.Cells[pos + i, 11 ].Value = "=SUM(K7:K"+(pos+i-1)+")";
			exSheet_3.Cells[pos + i, 12 ].Value = "=SUM(L7:L"+(pos+i-1)+")";			
		//------------------Sheet 5--------------------------
		dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fe0400130_FOSE05_6" , para);

		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet_4.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet_4.Cells[pos + i, 1 ].Value = i+1;
			for (int j=2;j<dtDetail.Columns.Count+2;j++)
			{
				exSheet_4.Cells[pos + i, j ].Value = dtDetail.Rows[i][j-2];
			}
			
        }
		//---------
			exSheet_4.Cells[pos + i, 3 ].Value = "=SUM(C7:C"+(pos+i-1)+")";
			exSheet_4.Cells[pos + i, 4 ].Value = "=SUM(D7:D"+(pos+i-1)+")";			
			exSheet_4.Cells[pos + i, 5 ].Value = "=SUM(E7:E"+(pos+i-1)+")";
			exSheet_4.Cells[pos + i, 6 ].Value = "=SUM(G7:G"+(pos+i-1)+")";
			exSheet_4.Cells[pos + i, 7 ].Value = "=SUM(I7:I"+(pos+i-1)+")";				
			exSheet_4.Cells[pos + i, 8 ].Value = "=SUM(K7:K"+(pos+i-1)+")";	
			exSheet_4.Cells[pos + i, 9 ].Value = "=SUM(M7:M"+(pos+i-1)+")";	
			exSheet_4.Cells[pos + i, 10 ].Value = "=SUM(O7:O"+(pos+i-1)+")";
			exSheet_4.Cells[pos + i, 11 ].Value = "=SUM(Q7:Q"+(pos+i-1)+")";
			exSheet_4.Cells[pos + i, 12 ].Value = "=SUM(S7:S"+(pos+i-1)+")";			
			exSheet_4.Cells[pos + i, 13 ].Value = "=SUM(U7:U"+(pos+i-1)+")";	
			exSheet_4.Cells[pos + i, 14 ].Value = "=SUM(W7:W"+(pos+i-1)+")";				
			exSheet_4.Cells[pos + i, 15 ].Value = "=SUM(Y7:Y"+(pos+i-1)+")";				
			exSheet_4.Cells[pos + i, 16 ].Value = "=SUM(AA7:AA"+(pos+i-1)+")";				
			exSheet_4.Cells[pos + i, 17 ].Value = "=SUM(AC7:AC"+(pos+i-1)+")";				
		//------------------Sheet 6--------------------------
		dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fe0400130_FOSE05_7" , para);

		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet_5.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet_5.Cells[pos + i, 1 ].Value = i+1;
			for (int j=2;j<dtDetail.Columns.Count+2;j++)
			{
				exSheet_5.Cells[pos + i, j ].Value = dtDetail.Rows[i][j-2];
			}
			
        }
		//---------
			exSheet_5.Cells[pos + i, 3 ].Value = "=SUM(C7:C"+(pos+i-1)+")";
			exSheet_5.Cells[pos + i, 4 ].Value = "=SUM(D7:D"+(pos+i-1)+")";			
			exSheet_5.Cells[pos + i, 5 ].Value = "=SUM(E7:E"+(pos+i-1)+")";
			exSheet_5.Cells[pos + i, 6 ].Value = "=SUM(G7:G"+(pos+i-1)+")";
			exSheet_5.Cells[pos + i, 7 ].Value = "=SUM(I7:I"+(pos+i-1)+")";				
			exSheet_5.Cells[pos + i, 8 ].Value = "=SUM(K7:K"+(pos+i-1)+")";	
			exSheet_5.Cells[pos + i, 9 ].Value = "=SUM(M7:M"+(pos+i-1)+")";	
			exSheet_5.Cells[pos + i, 10 ].Value = "=SUM(O7:O"+(pos+i-1)+")";
			exSheet_5.Cells[pos + i, 11 ].Value = "=SUM(Q7:Q"+(pos+i-1)+")";
			exSheet_5.Cells[pos + i, 12 ].Value = "=SUM(S7:S"+(pos+i-1)+")";			
			exSheet_5.Cells[pos + i, 13 ].Value = "=SUM(U7:U"+(pos+i-1)+")";	
			exSheet_5.Cells[pos + i, 14 ].Value = "=SUM(W7:W"+(pos+i-1)+")";				
			exSheet_5.Cells[pos + i, 15 ].Value = "=SUM(Y7:Y"+(pos+i-1)+")";				
			exSheet_5.Cells[pos + i, 16 ].Value = "=SUM(AA7:AA"+(pos+i-1)+")";				
			exSheet_5.Cells[pos + i, 17 ].Value = "=SUM(AC7:AC"+(pos+i-1)+")";	
			
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