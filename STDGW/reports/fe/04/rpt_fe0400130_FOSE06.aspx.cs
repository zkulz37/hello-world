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

public partial class rpt_fe0400130_FOSE06 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_fe0400130_FOSE06.xls";
        string TempFile = "../../../system/temp/rpt_fe0400130_FOSE06_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		IWorkbook exBook_1 = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		
		
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
		IWorksheet exSheet_1 = exBook.Worksheets[2];
		
        IRange range;

        //bind data to excel file
		 
        string wh_type , wh_pk , from_dt , to_dt , chk_amount, chk_act ;
        
		wh_type 	= Request.QueryString["wh_type"];
		wh_pk 		= Request.QueryString["wh_pk"];
		from_dt 	= Request.QueryString["from_dt"];
		to_dt 		= Request.QueryString["to_dt"];
         
        string para = "'" + wh_type + "','" + wh_pk + "','" + from_dt + "','" + to_dt + "'";	

		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_fe0400130_FOSE06_1", "'" + Session["User_ID"].ToString() + "'");				
			
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
			
        }
		
		//--------------Sheet 1-----------------		
		exSheet.Cells["C1"].Value = dtInfo.Rows[0]["partner_name"];
		exSheet.Cells["C2"].Value = dtInfo.Rows[0]["addr1"];
		exSheet.Cells["C3"].Value = "Tax Code: " + dtInfo.Rows[0]["tax_code"];
		
		exSheet.Cells["G1"].Value = "Tel: "      + dtInfo.Rows[0]["phone_no"];
		exSheet.Cells["G2"].Value = "Fax No: "   + dtInfo.Rows[0]["fax_no"]; 
		exSheet.Cells["G3"].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");
        exSheet.Cells["A4"].Value = "Tổng hợp theo bếp ( Nhập xuất tồn) ( " + from_dt.Substring(6, 2).ToString() + "/" + from_dt.Substring(4, 2).ToString() + "/" + from_dt.Substring(0, 4).ToString() + " - " + to_dt.Substring(6, 2).ToString() + "/" + to_dt.Substring(4, 2).ToString() + "/" + to_dt.Substring(0, 4).ToString() + " )";
		//---------------Sheet 2----------------		
		exSheet.Range["A1:K4"].Copy(exSheet_1.Range["A1:K3"], XlPasteType.xlPasteAll);
        exSheet_1.Cells["A4"].Value = "Tổng hợp theo ngày ( Nhập xuất tồn) ( " + from_dt.Substring(6, 2).ToString() + "/" + from_dt.Substring(4, 2).ToString() + "/" + from_dt.Substring(0, 4).ToString() + " - " + to_dt.Substring(6, 2).ToString() + "/" + to_dt.Substring(4, 2).ToString() + "/" + to_dt.Substring(0, 4).ToString() + " )";
		
		//-------------------------------	
		//tong tin master
			
		// SET DATA
		int pos = 8 ;
		int i   = 0  ;
        
		//------------------Sheet 1--------------------------
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fe0400130_FOSE06_2" , para);

        double[] d_total = new double[dtDetail.Columns.Count];

		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A" + (pos+1)].Rows.EntireRow.Insert();//insert row new of sheet
        }
        for (int j = 0; j < dtDetail.Columns.Count; j++)
        {
            d_total[j] = 0;
        }
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet.Cells[pos + i, 1 ].Value = i+1;
            exSheet.Cells[pos + i, 2].Value = dtDetail.Rows[i][0];
            for (int j = 1; j < dtDetail.Columns.Count; j++)
			{
				exSheet.Cells[pos + i, j+2 ].Value = dtDetail.Rows[i][j];
                d_total[j] = d_total[j] + Double.Parse(dtDetail.Rows[i][j].ToString());
			}
			
        }
		//---------
        for (int j = 1; j < dtDetail.Columns.Count; j++)
        {
            if (j!=6 && j!=11 && j!=16 && j!=21 && j!=26)
                exSheet.Cells[pos + i, j + 2].Value = d_total[j];
        }

        //------------------Sheet 2--------------------------
        dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fe0400130_FOSE06_3", para);

        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet_1.Range["A" + (pos + 1)].Rows.EntireRow.Insert();//insert row new of sheet
        }
        for (int j = 0; j < dtDetail.Columns.Count; j++)
        {
            d_total[j] = 0;
        }
        for (i = 0; i < dtDetail.Rows.Count; i++)
        {
            exSheet_1.Cells[pos + i, 1].Value = i + 1;
            exSheet_1.Cells[pos + i, 2].Value = dtDetail.Rows[i][0];
            for (int j = 1; j < dtDetail.Columns.Count; j++)
            {
                exSheet_1.Cells[pos + i, j + 2].Value = dtDetail.Rows[i][j];
                d_total[j] = d_total[j] + Double.Parse(dtDetail.Rows[i][j].ToString());
            }

        }
        //---------
        for (int j = 1; j < dtDetail.Columns.Count; j++)
        {
            if (j != 6 && j != 11 && j != 16 && j != 21 && j != 26)
                exSheet_1.Cells[pos + i, j + 2].Value = d_total[j];
        }
					 	
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