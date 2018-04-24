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

public partial class rpt_epbp00110_YJ01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_epbp00110_YJ01.xls";
        string TempFile = "../../../system/temp/rpt_epbp00110_YJ01_" + DateTime.Now.ToString("hhmmss") +Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		 
         string po_pk;
        po_pk = Request.QueryString["p_po_po_m_pk"];
         
        string para = "'" + po_pk + "'";		
		DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_epbp00110_YJ01_2" , para);		
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_epbp00110_YJ01_3" , para);		  
		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_epbp00110_YJ01_1", "'" + Session["User_ID"].ToString() + "'");	
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
				
		exSheet.Cells["C1"].Value = dtInfo.Rows[0]["partner_name"];
		exSheet.Cells["C2"].Value = dtInfo.Rows[0]["addr1"];
		exSheet.Cells["C3"].Value = "Tax Code: " + dtInfo.Rows[0]["tax_code"];
		
		exSheet.Cells["H1"].Value = "Tel: "      + dtInfo.Rows[0]["phone_no"];
		exSheet.Cells["H2"].Value = "Fax No: "   + dtInfo.Rows[0]["fax_no"]; 
        		
		exSheet.Cells["H3"].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");
		
		exSheet.Cells["D14"].Value = dt.Rows[0]["etd_from"] + " - " +dt.Rows[0]["etd_to"];;
		//tong tin master
		if( dt.Rows.Count >0)
		{
			exSheet.Cells["C6"].Value = dt.Rows[0]["partner_name"];	
			exSheet.Cells["C7"].Value = dt.Rows[0]["sale_rep"];			
			exSheet.Cells["C8"].Value = dt.Rows[0]["description"];
			
			exSheet.Cells["C13"].Value = dt.Rows[0]["etd_from"];
			
			exSheet.Cells["H4"].Value = dt.Rows[0]["po_no"];
			exSheet.Cells["H5"].Value = dt.Rows[0]["ref_no"];
			exSheet.Cells["H6"].Value = dt.Rows[0]["po_date"];
			
			exSheet.Cells["H8"].Value = dt.Rows[0]["fax_no"];
			
			exSheet.Cells["C15"].Value = dt.Rows[0]["payment_term"];
			
			exSheet.Cells["G20"].Value = dt.Rows[0]["po_amt"];//sub total
			exSheet.Cells["G21"].Value = dt.Rows[0]["vat_amt"];
			exSheet.Cells["G22"].Value = dt.Rows[0]["total_amt"];
			
			exSheet.Cells["I20"].Value = dt.Rows[0]["PO_CCY"];//ccy
			exSheet.Cells["I21"].Value = dt.Rows[0]["PO_CCY"];
			exSheet.Cells["I22"].Value = dt.Rows[0]["PO_CCY"];
		}
		//exSheet.Cells["D7"].Value = dtInfo.Rows[0]["t_period"];
        // END MASTER
		
		// INSERT ROWS
		 
		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A20"].Rows.EntireRow.Insert();//insert row new of sheet
        }
						
		// SET DATA
		int pos = 19 ;
		int i   = 0  ;		  						
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet.Cells[pos + i, 1 ].Value = i+1;
			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["ref_no"];
			exSheet.Cells[pos + i, 3 ].Value = dtDetail.Rows[i]["po_item_code"];
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["po_item_name"];
			//exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["spec02_nm"];
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["po_uom"];
			exSheet.Cells[pos + i, 6 ].Value = dtDetail.Rows[i]["po_qty"];
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["unit_price"];
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["po_amt"]; 
			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["description"]; 		
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