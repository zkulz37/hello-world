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

public partial class rpt_fppr00320_ST02 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_fppr00320_ST02.xls";
        string TempFile = "../../../system/temp/rpt_fppr00320_ST02_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		
		string p_master_pk 	= Request.QueryString["p_master_pk"];	
		 
        string para ;
				
		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_fppr00320_ST02_1" , "'" + Session["User_ID"].ToString() + "'");	
		
		para = "'" + p_master_pk + "'";	
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fppr00320_ST02_2" , para);	
	 
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
		exSheet.Cells["C1"].Value = dtInfo.Rows[0]["partner_name"];
		exSheet.Cells["C2"].Value = dtInfo.Rows[0]["addr1"];
		exSheet.Cells["C3"].Value = "Tax Code: " + dtInfo.Rows[0]["tax_code"];
		
		exSheet.Cells["G1"].Value = "Tel: "      + dtInfo.Rows[0]["phone_no"];
		exSheet.Cells["G2"].Value = "Fax No: "   + dtInfo.Rows[0]["fax_no"]; 
		exSheet.Cells["G3"].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");		        
		//-------------------------------	
		
		// INSERT ROWS
		 
		/*for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A9"].Rows.EntireRow.Insert();//insert row new of sheet
        }*/
						
		// SET DATA
		int pos = 8 ;
		int i   = 0  ;	

		string l_line_pk = "";	
		string l_seq     = "";
		
		double l_total_qty_out = 0;
		double l_total_qty_in  = 0;
		double l_total_qty     = 0;
		
		double l_total_amt = 0;		
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {			
								
			if ((l_line_pk != dtDetail.Rows[i]["tlg_pb_line_pk"].ToString() && l_line_pk != "") || (l_seq != dtDetail.Rows[i]["seq"].ToString() && l_seq != ""))
			{
				pos = pos + 1 ;
				exSheet.Range[ pos, 1 ].Rows.EntireRow.Insert();
				
				exSheet.Cells[ pos, 1, pos, 4].Merge();					 
				
				exSheet.Range[ pos, 1, pos, 9].Interior.Color = Color.Yellow;
				
				exSheet.Cells[ pos, 1].Value = "Total";
				
				exSheet.Cells[ pos, 5].Value = l_total_qty;
				exSheet.Cells[ pos, 7].Value = l_total_amt;
				
				if ( l_seq=="1" )
				{
					l_total_qty_in = l_total_qty;
				}
				else
				{				
					l_total_qty_out = l_total_qty;
					
					exSheet.Cells[ pos, 8].Value = l_total_qty_out / l_total_qty_in;
				}
				
				l_total_qty = 0;
				l_total_amt = 0;
			}
			
			l_line_pk = dtDetail.Rows[i]["tlg_pb_line_pk"].ToString();
			l_seq 	  = dtDetail.Rows[i]["seq"].ToString();
			
			pos = pos + 1 ;
			exSheet.Range[ pos, 1 ].Rows.EntireRow.Insert();	
			exSheet.Range[ pos, 1, pos, 9].Interior.Color = Color.White;
			
			exSheet.Cells[ pos, 1].Value = dtDetail.Rows[i]["seq"];					
						
			exSheet.Cells[ pos, 2].Value = dtDetail.Rows[i]["item_code"];
			exSheet.Cells[ pos, 3].Value = dtDetail.Rows[i]["item_name"];
			exSheet.Cells[ pos, 4].Value = dtDetail.Rows[i]["uom"];								 		
			exSheet.Cells[ pos, 5].Value = dtDetail.Rows[i]["tr_qty"];			
			exSheet.Cells[ pos, 6].Value = dtDetail.Rows[i]["unit_price"];			
			exSheet.Cells[ pos, 7].Value = dtDetail.Rows[i]["tr_amount"];
			
			if ( l_seq == "2" )
			{
				exSheet.Cells[ pos, 8].Value = Convert.ToDouble(dtDetail.Rows[i]["tr_qty"]) / l_total_qty_in;
			}
			
			l_total_qty += Convert.ToDouble(dtDetail.Rows[i]["tr_qty"]);	
			l_total_amt += Convert.ToDouble(dtDetail.Rows[i]["tr_amount"]);
			
			if ( i == dtDetail.Rows.Count-1 )
			{
				pos = pos + 1 ;
				exSheet.Range[ pos, 1 ].Rows.EntireRow.Insert();
				
				exSheet.Cells[ pos, 1, pos, 4].Merge();					 
				
				exSheet.Range[ pos, 1, pos, 9].Interior.Color = Color.Yellow;
				
				exSheet.Cells[ pos, 1].Value = "Total";
				
				exSheet.Cells[ pos, 5].Value = l_total_qty;
				exSheet.Cells[ pos, 7].Value = l_total_amt;
				
				if ( l_seq=="1" )
				{
					l_total_qty_in = l_total_qty;
				}
				else
				{				
					l_total_qty_out = l_total_qty;
					
					exSheet.Cells[ pos, 8].Value = l_total_qty_out / l_total_qty_in;
				}
				
				l_total_qty = 0;
				l_total_amt = 0;
			}
        }
		//---------
        
		int t = pos+i-1 ;
		
		/*exSheet.Cells[pos + i,  4].Value = "=sum(D8:D"+t+")";		
		exSheet.Cells[pos + i,  9].Value = "=sum(I8:I"+t+")";	
		exSheet.Cells[pos + i, 10].Value = "=sum(J8:J"+t+")";*/
		
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