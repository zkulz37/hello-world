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

public partial class rpt_epex00030_SW01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		//ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_epex00030_SW01.xls";
        string TempFile = "../../../system/temp/rpt_epex00030_SW01_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
		IWorksheet exSheet2 = exBook.Worksheets[1];//CI
        IWorksheet exSheet = exBook.Worksheets[2];//PL
		
        IRange range;

        //bind data to excel file
		 
        string p_master_pk;
        p_master_pk = Request.QueryString["p_master_pk"];
         
        string para = "'" + p_master_pk + "'";		
		DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_epex00030_sw01" , para);
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_epex00030_sw01_1" , para);		  
		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_epex00030_sw01_2", "'" + Session["User_ID"].ToString() + "'");	
        // MASTER   

		//--set-----DataBind--in---Master---
        /*if (!string.IsNullOrEmpty(dtInfo.Rows[0]["pic"].ToString()))
        {
            exSheet.Cells[1, 1].Select();
            byte[] MyData = new byte[0];
            MyData = (byte[])dtInfo.Rows[0]["pic"];
            MemoryStream stream = new MemoryStream(MyData);

            Bitmap b = new Bitmap(stream);
            exSheet.Shapes.AddPicture(ResizeImage(b, 90, 59));
        }*/
		//sheet 1		
		exSheet.Cells["A3"].Value = dtInfo.Rows[0]["partner_name"];
		exSheet.Cells["A4"].Value = dtInfo.Rows[0]["addr1"];
		//sheet 2	
		exSheet2.Cells["A3"].Value = dtInfo.Rows[0]["partner_name"];
		exSheet2.Cells["A4"].Value = dtInfo.Rows[0]["addr1"];
		/*exSheet.Cells["C3"].Value = "Tax Code: " + dtInfo.Rows[0]["tax_code"];*/
		
		//exSheet.Cells["B8"].Value = dtInfo.Rows[0]["phone_no"];
		//exSheet.Cells["D8"].Value = dtInfo.Rows[0]["fax_no"]; 
        		
		//exSheet.Cells["G3"].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");
		//tong tin master
		if( dt.Rows.Count >0)
		{
			exSheet.Cells["G3"].Value = dt.Rows[0]["co_invoice_no"];
			exSheet.Cells["I3"].Value = "Date :"+dt.Rows[0]["co_invoice_date"];
			
			exSheet.Cells["G5"].Value = dt.Rows[0]["contract_no"];
			//exSheet.Cells["I5"].Value = "Date :"+dt.Rows[0]["co_invoice_date"];
			
			exSheet.Cells["A8"].Value = dt.Rows[0]["cust_name"];//supplier
			exSheet.Cells["A9"].Value = dt.Rows[0]["cust_addr1"];
			
			exSheet.Cells["G10"].Value = dt.Rows[0]["etd_from"];
			exSheet.Cells["H10"].Value = dt.Rows[0]["eta_from"];
			
			exSheet.Cells["G14"].Value =dt.Rows[0]["price_type"];//Delivery term
			exSheet.Cells["H14"].Value = dt.Rows[0]["payment_term"];
			
			exSheet.Cells["G12"].Value ="Country of Origin of Goods";//Country of Origin of Goods
			exSheet.Cells["I12"].Value = "Country of Final Destination";//Country of Final Destination
			exSheet.Cells["A13"].Value ="Pre-Carriage by";//Pre-Carriage by
			exSheet.Cells["C13"].Value = "Place of Receipt by Pre-carrier";//Place of Receipt by Pre-carrier
			exSheet.Cells["A15"].Value ="Vessel/Flight No.";//Vessel/Flight No.
			exSheet.Cells["C15"].Value = dt.Rows[0]["dm_port"];//port of load
			exSheet.Cells["A17"].Value ="Port of Discharge";//Port of Discharge
			exSheet.Cells["C17"].Value = dt.Rows[0]["os_port"];//final destination
			
			//sheet 2
			exSheet2.Cells["G3"].Value = dt.Rows[0]["co_invoice_no"];
			exSheet2.Cells["I3"].Value = "Date :"+dt.Rows[0]["co_invoice_date"];
			
			exSheet2.Cells["G5"].Value = dt.Rows[0]["contract_no"];
			//exSheet2.Cells["I5"].Value = "Date :"+dt.Rows[0]["co_invoice_date"];
			
			exSheet2.Cells["A8"].Value = dt.Rows[0]["cust_name"];//supplier
			exSheet2.Cells["A9"].Value = dt.Rows[0]["cust_addr1"];
			
			exSheet2.Cells["G10"].Value = dt.Rows[0]["etd_from"];
			exSheet2.Cells["H10"].Value = dt.Rows[0]["eta_from"];
			
			exSheet2.Cells["G14"].Value =dt.Rows[0]["price_type"];//Delivery term
			exSheet2.Cells["H14"].Value = dt.Rows[0]["payment_term"];
			
			exSheet2.Cells["G12"].Value ="Country of Origin of Goods";//Country of Origin of Goods
			exSheet2.Cells["I12"].Value = "Country of Final Destination";//Country of Final Destination
			exSheet2.Cells["A13"].Value ="Pre-Carriage by";//Pre-Carriage by
			exSheet2.Cells["C13"].Value = "Place of Receipt by Pre-carrier";//Place of Receipt by Pre-carrier
			exSheet2.Cells["A15"].Value ="Vessel/Flight No.";//Vessel/Flight No.
			exSheet2.Cells["C15"].Value = dt.Rows[0]["dm_port"];//port of load
			exSheet2.Cells["A17"].Value ="Port of Discharge";//Port of Discharge
			exSheet2.Cells["C17"].Value = dt.Rows[0]["os_port"];//final destination
			
			
			
		}
		
        // END MASTER
		
		// INSERT ROWS
		 
		for (int l_addrow = 0; l_addrow < dtDetail.Rows.Count-1; l_addrow++)
        {
            exSheet.Range["A20"].Rows.EntireRow.Insert();//insert row new of sheet1
			exSheet2.Range["A20"].Rows.EntireRow.Insert();//insert row new of sheet2
        }
						
		// SET DATA
		int pos = 19 ;
		int i   = 0  ;		  			
		
		
		int cnt =	dtDetail.Rows.Count;		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
            //sheet 1
			exSheet.Range[pos + i, 2,pos + i, 3].Merge();
			exSheet.Range[pos + i, 4,pos + i, 6].Merge();
			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[0]["CARTON_QTY"];
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["item_desc"];
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["inv_qty"];
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["net_weight"];
			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["gross_weight"];
			 
			//sheet 2
			exSheet2.Range[pos + i, 2,pos + i, 3].Merge();
			exSheet2.Range[pos + i, 4,pos + i, 6].Merge();
			exSheet2.Cells[pos + i, 2 ].Value = dtDetail.Rows[0]["CARTON_QTY"];
			exSheet2.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["item_desc"];
			exSheet2.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["inv_qty"];
			exSheet2.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["inv_unit_price"];
			exSheet2.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["inv_item_amount"];	
        }
		//---------
		if(cnt > 0)
		{
			//sheet1
			exSheet.Range[19, 1,cnt+18, 1].Merge();
			exSheet.Cells[19, 1 ].Value = dt.Rows[0]["packing_marks"];
			//sheet2
			exSheet2.Range[19, 1,cnt+18, 1].Merge();
			exSheet2.Cells[19, 1 ].Value = dt.Rows[0]["packing_marks"];
			
		}
		//sheet1
		exSheet.Cells[pos + i, 7 ].Value = "=sum(G19:G"+(pos+i-1)+")";
		exSheet.Cells[pos + i, 8].Value  = "=sum(H19:H"+(pos+i-1)+")";
		exSheet.Cells[pos + i, 9].Value  = "=sum(I19:I"+(pos+i-1)+")";
		//sheet2
		exSheet2.Cells[pos + i, 7 ].Value = "=sum(G19:G"+(pos+i-1)+")";
		exSheet2.Cells[pos + i, 8].Value  = "=sum(H19:H"+(pos+i-1)+")";
		exSheet2.Cells[pos + i, 9].Value  = "=sum(I19:I"+(pos+i-1)+")";	
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