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

public partial class rpt_dsmr00020 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		//ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_dsmr00020.xls";
        string TempFile = "../../../system/temp/rpt_dsmr00020_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		 
       
      string  p_date_from = Request.QueryString["p_date_from"];
      string  p_date_to = Request.QueryString["p_date_to"];
      string  p_line_group = Request.QueryString["p_line_group"];
      string  P_radType = Request.QueryString["P_radType"];
        
        string para = "'" +p_line_group  + "','" +p_date_from  + "','" +p_date_to + "','" + P_radType + "'";		
		DataTable dt = ESysLib.TableReadOpenCursor("lg_sel_dsmr00020" , para);		
		
		
		for (int l_addrow = 0; l_addrow < dt.Rows.Count-1; l_addrow++)
        {
            exSheet.Range["A9"].Rows.EntireRow.Insert();
        }
		int pos = 8 ;		
		
		for (int i = 0; i < dt.Rows.Count; i++)
        {								
           
			exSheet.Cells[pos + i, 2 ].Value = dt.Rows[i]["line_group"]; 			
			exSheet.Cells[pos + i, 3 ].Value = dt.Rows[i]["doc_date"]; 			
			exSheet.Cells[pos + i, 4 ].Value = dt.Rows[i]["ord_no"]; 			
			exSheet.Cells[pos + i, 5 ].Value = dt.Rows[i]["buyer"]; 			
			exSheet.Cells[pos + i, 6 ].Value = dt.Rows[i]["pattern"]; 			
			exSheet.Cells[pos + i, 7 ].Value = dt.Rows[i]["item_code"]; 			
			exSheet.Cells[pos + i, 8].Value = dt.Rows[i]["wi_qty"]; 			
			exSheet.Cells[pos + i, 9].Value = dt.Rows[i]["balance"]; 			
			exSheet.Cells[pos + i, 10].Value = dt.Rows[i]["wh01"]; 			
			exSheet.Cells[pos + i, 11].Value = dt.Rows[i]["wh02"]; 			
			exSheet.Cells[pos + i, 12].Value = dt.Rows[i]["wh03"]; 			
			exSheet.Cells[pos + i, 13].Value = dt.Rows[i]["wh04"]; 			
			exSheet.Cells[pos + i, 14].Value = dt.Rows[i]["wh05"]; 			
			exSheet.Cells[pos + i, 15].Value = dt.Rows[i]["wh06"]; 			
			exSheet.Cells[pos + i, 16].Value = dt.Rows[i]["wh07"]; 			
			exSheet.Cells[pos + i, 17].Value = dt.Rows[i]["wh08"]; 			
			exSheet.Cells[pos + i, 18].Value = dt.Rows[i]["wh09"]; 			
			exSheet.Cells[pos + i, 19].Value = dt.Rows[i]["wh10"]; 			
			exSheet.Cells[pos + i, 20].Value = dt.Rows[i]["wh11"]; 			
			 

			if((dt.Rows[i]["doc_date"].ToString()=="")&&(dt.Rows[i]["ord_no"].ToString()==""))
					{
						string l_Color="0XFF66CC";//0XC0C0C0
						Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
						exSheet.Cells[pos + i, 2,pos + i, 28].Interior.Color = colorValueFrmHex;//set color grand total
						//exSheet_1.Cells[pos + i,2].Value="";//ko xuat hien row num
						exSheet.Cells[pos + i,3].Value="Total:";
						exSheet.Cells[pos + i,11].Value="";
					}	
			if((dt.Rows[i]["doc_date"].ToString()=="")&&(dt.Rows[i]["ord_no"].ToString()!=""))
					{
						string l_Color="0XFFCC66";//0XC0C0C0
						Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
						exSheet.Cells[pos + i, 2,pos + i, 28].Interior.Color = colorValueFrmHex;//set color grand total
						//exSheet_1.Cells[pos + i,2].Value="";//ko xuat hien row num
						exSheet.Cells[pos + i,3].Value="Sub Total:";
						exSheet.Cells[pos + i,11].Value="";
					}
				
        }
		
		//---------
		//exSheet.Cells[pos + i, 6 ].Value = "=sum(F10:F"+(pos+i-1)+")";
	//	exSheet.Cells[pos + i, 7].Value = "=sum(G10:G"+(pos+i-1)+")";			 					
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