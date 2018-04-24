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

public partial class rpt_epex00100_YJ01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		//ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_epex00100_YJ01.xls";
        string TempFile = "../../../system/temp/rpt_epex00100_YJ01_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		 
        string p_master_pk;
        p_master_pk = Request.QueryString["p_master_pk"];
         
        string para = "'" + p_master_pk + "'";		
		DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_epex00100_yj01" , para);		
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_epex00100_yj01_1" , para);		  
		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_epex00100_yj01_2", "'" + Session["User_ID"].ToString() + "'");	
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
				
		exSheet.Cells["B5"].Value = dtInfo.Rows[0]["partner_name"];
		exSheet.Cells["B6"].Value = dtInfo.Rows[0]["addr1"];
		/*exSheet.Cells["C3"].Value = "Tax Code: " + dtInfo.Rows[0]["tax_code"];
		
		exSheet.Cells["G1"].Value = "Tel: "      + dtInfo.Rows[0]["phone_no"];
		exSheet.Cells["G2"].Value = "Fax No: "   + dtInfo.Rows[0]["fax_no"]; 
        		
		exSheet.Cells["G3"].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");*/
		//tong tin master
		if( dt.Rows.Count >0)
		{
			exSheet.Cells["A2"].Value = dt.Rows[0]["contract_no"];
			exSheet.Cells["A3"].Value = dt.Rows[0]["co_invoice_date"];
			
			exSheet.Cells["B8"].Value = dt.Rows[0]["cust_name"];//supplier
			exSheet.Cells["B9"].Value = dt.Rows[0]["cust_addr1"];
			exSheet.Cells["B10"].Value = dt.Rows[0]["cust_addr2"];
			exSheet.Cells["E10"].Value = "Tel :"+dt.Rows[0]["phone_no"];//tel
			
			exSheet.Cells["C6"].Value = dt.Rows[0]["price_type"];
			exSheet.Cells["C7"].Value = dt.Rows[0]["payment_term"];
			exSheet.Cells["A20"].Value =dt.Rows[0]["bank_memo"];
			exSheet.Cells["b12"].Value =dt.Rows[0]["partner_ship_desc"];//Delivery term
			exSheet.Cells["B22"].Value =dt.Rows[0]["price_type"];//Delivery term
			exSheet.Cells["B23"].Value =dt.Rows[0]["payment_term"];
			exSheet.Cells["B24"].Value = dt.Rows[0]["lc_expiry_date"];
			
			//footer
			//exSheet.Cells["A28"].Value = dtInfo.Rows[0]["partner_name"];//yujin
			//exSheet.Cells["G28"].Value = dt.Rows[0]["cust_name"];//supplier
			   
		}
		//exSheet.Cells["D7"].Value = dtInfo.Rows[0]["t_period"];
        // END MASTER
		
		// INSERT ROWS
		 
		for (int l_addrow = 0; l_addrow < dtDetail.Rows.Count-1; l_addrow++)
        {
            exSheet.Range["A18"].Rows.EntireRow.Insert();//insert row new of sheet
        }
						
		// SET DATA
		int pos = 17 ;
		int i   = 0  ;		  			
		
		
					
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
            exSheet.Range[pos + i, 3,pos + i, 4].Merge();
			exSheet.Cells[pos + i, 1 ].Value = dtDetail.Rows[i]["ref_po_no"];
			//exSheet.Cells[pos + i, 1 ].Value = dtDetail.Rows[i]["ref_no"];
			//exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["item_name"];
			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["pattern"];
			exSheet.Cells[pos + i, 3 ].Value = dtDetail.Rows[i]["item_desc"];
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["inv_qty"];
			exSheet.Cells[pos + i, 6 ].Value = dtDetail.Rows[i]["inv_unit_price"];
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["inv_item_amount"];
			exSheet.Cells[pos + i, 8 ].Value = dt.Rows[0]["etd_from"]; 			
        }
		//---------
		exSheet.Cells[pos + i, 5 ].Value = "=sum(E17:E"+(pos+i-1)+")";
		exSheet.Cells[pos + i, 7].Value = "=sum(G17:G"+(pos+i-1)+")";			 					
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