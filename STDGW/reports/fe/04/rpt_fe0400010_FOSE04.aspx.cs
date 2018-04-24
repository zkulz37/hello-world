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

public partial class rpt_fe0400010_FOSE04 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_fe0400010_FOSE04.xls";
        string TempFile = "../../../system/temp/rpt_fe0400010_FOSE04_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		 
        string wh_type , wh_pk , from_dt , to_dt , chk_amount , chk_act ;
        
		wh_type 	= Request.QueryString["wh_type"];
		wh_pk 		= Request.QueryString["wh_pk"];
		from_dt 	= Request.QueryString["from_dt"];
		to_dt 		= Request.QueryString["to_dt"];
		chk_amount 	= Request.QueryString["chk_amount"];
		chk_act 	= Request.QueryString["chk_act"];
         
        string para = "'" + wh_type + "','" + wh_pk + "','" + from_dt + "','" + to_dt + "','" + chk_amount + "','" + chk_act + "'";	

		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_fe0400010_FOSE04_1", "'" + from_dt + "','" + Session["User_ID"].ToString() + "'");				
			
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
		
		exSheet.Cells["C5"].Value = dtInfo.Rows[0]["from_dt"]; ;
		
		//tong tin master
			
		// SET DATA
		int pos = 7 ;
		int i   = 0  ;		  						
		
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fe0400010_FOSE04_2" , para);

		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet.Cells[pos + i, 1 ].Value = i+1;

			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["warehouse"];
			
			exSheet.Cells[pos + i, 3 ].Value = dtDetail.Rows[i]["day00"];			
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["day01"];			
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["day02"];			
			exSheet.Cells[pos + i, 6 ].Value = dtDetail.Rows[i]["day03"];				
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["day04"];	
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["day05"];	
			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["day06"];	 
			exSheet.Cells[pos + i,10 ].Value = dtDetail.Rows[i]["day07"];		
			exSheet.Cells[pos + i,11 ].Value = dtDetail.Rows[i]["day08"];	 			
			exSheet.Cells[pos + i,12 ].Value = dtDetail.Rows[i]["day09"];	
			exSheet.Cells[pos + i,13 ].Value = dtDetail.Rows[i]["day10"];
			exSheet.Cells[pos + i,14 ].Value = dtDetail.Rows[i]["day11"];
			exSheet.Cells[pos + i,15 ].Value = dtDetail.Rows[i]["day12"];			
			exSheet.Cells[pos + i,16 ].Value = dtDetail.Rows[i]["day13"];
			
			exSheet.Cells[pos + i,17 ].Value = dtDetail.Rows[i]["day14"];	
			exSheet.Cells[pos + i,18 ].Value = dtDetail.Rows[i]["day15"];	 
			exSheet.Cells[pos + i,19 ].Value = dtDetail.Rows[i]["day16"];	
			exSheet.Cells[pos + i,20 ].Value = dtDetail.Rows[i]["day17"];	
			exSheet.Cells[pos + i,21 ].Value = dtDetail.Rows[i]["day18"];	
			exSheet.Cells[pos + i,22 ].Value = dtDetail.Rows[i]["day19"];	
			exSheet.Cells[pos + i,23 ].Value = dtDetail.Rows[i]["day20"];	
			exSheet.Cells[pos + i,24 ].Value = dtDetail.Rows[i]["day21"];	
			exSheet.Cells[pos + i,25 ].Value = dtDetail.Rows[i]["day22"];	
			exSheet.Cells[pos + i,26 ].Value = dtDetail.Rows[i]["day23"];				
			exSheet.Cells[pos + i,27 ].Value = dtDetail.Rows[i]["day24"];
			exSheet.Cells[pos + i,28 ].Value = dtDetail.Rows[i]["day25"];
			exSheet.Cells[pos + i,29 ].Value = dtDetail.Rows[i]["day26"];			
			exSheet.Cells[pos + i,30 ].Value = dtDetail.Rows[i]["day27"];
			
			exSheet.Cells[pos + i,31 ].Value = dtDetail.Rows[i]["day28"];	
			exSheet.Cells[pos + i,32 ].Value = dtDetail.Rows[i]["day29"];	
			exSheet.Cells[pos + i,33 ].Value = dtDetail.Rows[i]["day30"];	
			exSheet.Cells[pos + i,34 ].Value = dtDetail.Rows[i]["day31"];	
			
			exSheet.Cells[pos + i,35 ].Value = "=SUM(C"+(pos+i)+":AH"+(pos+i)+")";	
        }
		//---------
			exSheet.Cells[pos + i, 3 ].Value = "=SUM(C7:C"+(pos+i-1)+")";	 
			exSheet.Cells[pos + i, 4 ].Value = "=SUM(D7:D"+(pos+i-1)+")";	
			exSheet.Cells[pos + i, 5 ].Value = "=SUM(E7:E"+(pos+i-1)+")";			
			exSheet.Cells[pos + i, 6 ].Value = "=SUM(F7:F"+(pos+i-1)+")";
			exSheet.Cells[pos + i, 7 ].Value = "=SUM(G7:G"+(pos+i-1)+")";
			exSheet.Cells[pos + i, 8 ].Value = "=SUM(H7:H"+(pos+i-1)+")";
			exSheet.Cells[pos + i, 9 ].Value = "=SUM(I7:I"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,10 ].Value = "=SUM(J7:J"+(pos+i-1)+")";		
			exSheet.Cells[pos + i,11 ].Value = "=SUM(K7:K"+(pos+i-1)+")";
			exSheet.Cells[pos + i,12 ].Value = "=SUM(L7:L"+(pos+i-1)+")";				
			exSheet.Cells[pos + i,13 ].Value = "=SUM(M7:M"+(pos+i-1)+")"; 
			exSheet.Cells[pos + i,14 ].Value = "=SUM(N7:N"+(pos+i-1)+")";
			exSheet.Cells[pos + i,15 ].Value = "=SUM(O7:O"+(pos+i-1)+")";			
			exSheet.Cells[pos + i,16 ].Value = "=SUM(P7:P"+(pos+i-1)+")";
			exSheet.Cells[pos + i,17 ].Value = "=SUM(Q7:Q"+(pos+i-1)+")";
			exSheet.Cells[pos + i,18 ].Value = "=SUM(R7:R"+(pos+i-1)+")";
			exSheet.Cells[pos + i,19 ].Value = "=SUM(S7:S"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,20 ].Value = "=SUM(T7:T"+(pos+i-1)+")";		
			exSheet.Cells[pos + i,21 ].Value = "=SUM(U7:U"+(pos+i-1)+")";
			exSheet.Cells[pos + i,22 ].Value = "=SUM(V7:V"+(pos+i-1)+")";				
			exSheet.Cells[pos + i,23 ].Value = "=SUM(W7:W"+(pos+i-1)+")"; 
			exSheet.Cells[pos + i,24 ].Value = "=SUM(X7:X"+(pos+i-1)+")";
			exSheet.Cells[pos + i,25 ].Value = "=SUM(Y7:Y"+(pos+i-1)+")";
			exSheet.Cells[pos + i,26 ].Value = "=SUM(Z7:Z"+(pos+i-1)+")";
			exSheet.Cells[pos + i,27 ].Value = "=SUM(AA7:AA"+(pos+i-1)+")";
			exSheet.Cells[pos + i,28 ].Value = "=SUM(AB7:AB"+(pos+i-1)+")";
			exSheet.Cells[pos + i,29 ].Value = "=SUM(AC7:AC"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,30 ].Value = "=SUM(AD7:AD"+(pos+i-1)+")";		
			exSheet.Cells[pos + i,31 ].Value = "=SUM(AE7:AE"+(pos+i-1)+")";
			exSheet.Cells[pos + i,32 ].Value = "=SUM(AF7:AF"+(pos+i-1)+")";
			exSheet.Cells[pos + i,33 ].Value = "=SUM(AG7:AG"+(pos+i-1)+")";
			exSheet.Cells[pos + i,34 ].Value = "=SUM(AH7:AH"+(pos+i-1)+")";
			exSheet.Cells[pos + i,35 ].Value = "=SUM(AI7:AI"+(pos+i-1)+")";			 
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