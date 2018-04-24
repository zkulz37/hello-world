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

public partial class rpt_epbp00330_FOSE03 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_epbp00330_FOSE03.xls";
        string TempFile = "../../../system/temp/rpt_epbp00330_FOSE03_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		
		string p_date_type 	= Request.QueryString["p_date_type"];	
		string p_from_date 	= Request.QueryString["p_from_date"];
		string p_dept_pk 	= Request.QueryString["p_dept_pk"];
		string p_item 		= Request.QueryString["p_item"];
		string p_partner 	= Request.QueryString["p_partner"];
		string p_lang 		= Request.QueryString["p_lang"];
         
        string para ;
				
		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_epbp00330_FOSE03_1" , "'" + Session["User_ID"].ToString() + "'");	
		
		para = "'" + p_from_date + "','" + p_dept_pk + "'";	
		DataTable dtMaster = ESysLib.TableReadOpenCursor("lg_rpt_epbp00330_FOSE03_2" , para);	

		para = "'" + p_from_date + "'";	
		DataTable dtHeader = ESysLib.TableReadOpenCursor("lg_rpt_epbp00330_FOSE03_3" , para);	
		
		para = "'" + p_date_type + "','" + p_from_date + "','" + p_dept_pk + "','" + p_item + "','" + p_partner + "','" + p_lang + "'";			
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_epbp00330_FOSE03_4" , para);
				 
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
		//tong tin master
		if( dtMaster.Rows.Count >0)
		{
			exSheet.Cells["H4"].Value = dtMaster.Rows[0]["dept_name"];
			exSheet.Cells["H5"].Value = dtMaster.Rows[0]["req_date"];
		}
		  
        // END HEADER
		if( dtHeader.Rows.Count >0)
		{
			exSheet.Cells[7, 5].Value = dtHeader.Rows[0]["day_00"];
			exSheet.Cells[7, 6].Value = dtHeader.Rows[0]["day_01"];		
			exSheet.Cells[7, 7].Value = dtHeader.Rows[0]["day_02"];	
			exSheet.Cells[7, 8].Value = dtHeader.Rows[0]["day_03"];
			exSheet.Cells[7, 9].Value = dtHeader.Rows[0]["day_04"];
			exSheet.Cells[7,10].Value = dtHeader.Rows[0]["day_05"];
			exSheet.Cells[7,11].Value = dtHeader.Rows[0]["day_06"];
			exSheet.Cells[7,12].Value = dtHeader.Rows[0]["day_07"];
			exSheet.Cells[7,13].Value = dtHeader.Rows[0]["day_08"];
			exSheet.Cells[7,14].Value = dtHeader.Rows[0]["day_09"];
			exSheet.Cells[7,15].Value = dtHeader.Rows[0]["day_10"];
			exSheet.Cells[7,16].Value = dtHeader.Rows[0]["day_11"];
			exSheet.Cells[7,17].Value = dtHeader.Rows[0]["day_12"];
			exSheet.Cells[7,18].Value = dtHeader.Rows[0]["day_13"];
			exSheet.Cells[7,19].Value = dtHeader.Rows[0]["day_14"];
			exSheet.Cells[7,20].Value = dtHeader.Rows[0]["day_15"];
			exSheet.Cells[7,21].Value = dtHeader.Rows[0]["day_16"];
			exSheet.Cells[7,22].Value = dtHeader.Rows[0]["day_17"];
			exSheet.Cells[7,23].Value = dtHeader.Rows[0]["day_18"];
			exSheet.Cells[7,24].Value = dtHeader.Rows[0]["day_19"];
			exSheet.Cells[7,25].Value = dtHeader.Rows[0]["day_20"];
			exSheet.Cells[7,26].Value = dtHeader.Rows[0]["day_21"];
			exSheet.Cells[7,27].Value = dtHeader.Rows[0]["day_22"];
			exSheet.Cells[7,28].Value = dtHeader.Rows[0]["day_23"];
			exSheet.Cells[7,29].Value = dtHeader.Rows[0]["day_24"];
			exSheet.Cells[7,30].Value = dtHeader.Rows[0]["day_25"];
			exSheet.Cells[7,31].Value = dtHeader.Rows[0]["day_26"];
			exSheet.Cells[7,32].Value = dtHeader.Rows[0]["day_27"];
			exSheet.Cells[7,33].Value = dtHeader.Rows[0]["day_28"];
			exSheet.Cells[7,34].Value = dtHeader.Rows[0]["day_29"];
			exSheet.Cells[7,35].Value = dtHeader.Rows[0]["day_30"];
		}
		 	 		
						
		// SET DATA
		int pos 	= 8 ;
		int i   	= 0 ;	
		int last_i 	= 8 ;		
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {
			exSheet.Range[pos+i+1, 1].Rows.EntireRow.Insert();
			
			exSheet.Cells[pos + i, 1 ].Value = dtDetail.Rows[i]["grp_cd"];			
			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["item_code"];
			exSheet.Cells[pos + i, 3 ].Value = dtDetail.Rows[i]["item_name"];
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["req_uom"];	
			
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["day00_qty"];
			exSheet.Cells[pos + i, 6 ].Value = dtDetail.Rows[i]["day01_qty"];			
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["day02_qty"];			
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["day03_qty"];
			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["day04_qty"];
			exSheet.Cells[pos + i,10 ].Value = dtDetail.Rows[i]["day05_qty"]; 
			exSheet.Cells[pos + i,11 ].Value = dtDetail.Rows[i]["day06_qty"]; 	
			exSheet.Cells[pos + i,12 ].Value = dtDetail.Rows[i]["day07_qty"]; 			
			exSheet.Cells[pos + i,13 ].Value = dtDetail.Rows[i]["day08_qty"]; 
			exSheet.Cells[pos + i,14 ].Value = dtDetail.Rows[i]["day09_qty"]; 			
			exSheet.Cells[pos + i,15 ].Value = dtDetail.Rows[i]["day10_qty"]; 
			exSheet.Cells[pos + i,16 ].Value = dtDetail.Rows[i]["day11_qty"]; 
			exSheet.Cells[pos + i,17 ].Value = dtDetail.Rows[i]["day12_qty"]; 
			exSheet.Cells[pos + i,18 ].Value = dtDetail.Rows[i]["day13_qty"];
			exSheet.Cells[pos + i,19 ].Value = dtDetail.Rows[i]["day14_qty"];
			exSheet.Cells[pos + i,20 ].Value = dtDetail.Rows[i]["day15_qty"];
			exSheet.Cells[pos + i,21 ].Value = dtDetail.Rows[i]["day16_qty"];
			exSheet.Cells[pos + i,22 ].Value = dtDetail.Rows[i]["day17_qty"];
			exSheet.Cells[pos + i,23 ].Value = dtDetail.Rows[i]["day18_qty"];
			exSheet.Cells[pos + i,24 ].Value = dtDetail.Rows[i]["day19_qty"];
			exSheet.Cells[pos + i,25 ].Value = dtDetail.Rows[i]["day20_qty"];
			exSheet.Cells[pos + i,26 ].Value = dtDetail.Rows[i]["day21_qty"];
			exSheet.Cells[pos + i,27 ].Value = dtDetail.Rows[i]["day22_qty"];
			exSheet.Cells[pos + i,28 ].Value = dtDetail.Rows[i]["day23_qty"];
			exSheet.Cells[pos + i,29 ].Value = dtDetail.Rows[i]["day24_qty"];
			exSheet.Cells[pos + i,30 ].Value = dtDetail.Rows[i]["day25_qty"];
			exSheet.Cells[pos + i,31 ].Value = dtDetail.Rows[i]["day26_qty"];
			exSheet.Cells[pos + i,32 ].Value = dtDetail.Rows[i]["day27_qty"];
			exSheet.Cells[pos + i,33 ].Value = dtDetail.Rows[i]["day28_qty"];
			exSheet.Cells[pos + i,34 ].Value = dtDetail.Rows[i]["day29_qty"];
			exSheet.Cells[pos + i,35 ].Value = dtDetail.Rows[i]["day30_qty"]; 
			
			if ( ((i+1 < dtDetail.Rows.Count) && (dtDetail.Rows[i]["grp_cd"].ToString() != dtDetail.Rows[i+1]["grp_cd"].ToString())) || ( i+1 == dtDetail.Rows.Count ) )
			{					 				
				exSheet.Range[ pos+i+2, 1].Rows.EntireRow.Insert();
				
				exSheet.Cells[pos + i+1, 5 ].Value = "=SUM(E"+last_i+":E"+(pos+i)+")";
				exSheet.Cells[pos + i+1, 6 ].Value = "=SUM(F"+last_i+":F"+(pos+i)+")";		
				exSheet.Cells[pos + i+1, 7 ].Value = "=SUM(G"+last_i+":G"+(pos+i)+")";
				exSheet.Cells[pos + i+1, 8 ].Value = "=SUM(H"+last_i+":H"+(pos+i)+")";
				exSheet.Cells[pos + i+1, 9 ].Value = "=SUM(I"+last_i+":I"+(pos+i)+")";
				
				exSheet.Cells[pos + i+1,10 ].Value = "=SUM(J"+last_i+":J"+(pos+i)+")";
				exSheet.Cells[pos + i+1,11 ].Value = "=SUM(K"+last_i+":K"+(pos+i)+")"; 	
				exSheet.Cells[pos + i+1,12 ].Value = "=SUM(L"+last_i+":L"+(pos+i)+")";		
				exSheet.Cells[pos + i+1,13 ].Value = "=SUM(M"+last_i+":M"+(pos+i)+")";
				exSheet.Cells[pos + i+1,14 ].Value = "=SUM(N"+last_i+":N"+(pos+i)+")";	
				
				exSheet.Cells[pos + i+1,15 ].Value = "=SUM(O"+last_i+":O"+(pos+i)+")";
				exSheet.Cells[pos + i+1,16 ].Value = "=SUM(P"+last_i+":P"+(pos+i)+")";
				exSheet.Cells[pos + i+1,17 ].Value = "=SUM(Q"+last_i+":Q"+(pos+i)+")";
				exSheet.Cells[pos + i+1,18 ].Value = "=SUM(R"+last_i+":R"+(pos+i)+")";
				exSheet.Cells[pos + i+1,19 ].Value = "=SUM(S"+last_i+":S"+(pos+i)+")";
				
				exSheet.Cells[pos + i+1,20 ].Value = "=SUM(T"+last_i+":T"+(pos+i)+")";
				exSheet.Cells[pos + i+1,21 ].Value = "=SUM(U"+last_i+":U"+(pos+i)+")";
				exSheet.Cells[pos + i+1,22 ].Value = "=SUM(V"+last_i+":V"+(pos+i)+")";
				exSheet.Cells[pos + i+1,23 ].Value = "=SUM(W"+last_i+":W"+(pos+i)+")";
				exSheet.Cells[pos + i+1,24 ].Value = "=SUM(X"+last_i+":S"+(pos+i)+")";
				
				exSheet.Cells[pos + i+1,25 ].Value = "=SUM(Y"+last_i+":Y"+(pos+i)+")";
				exSheet.Cells[pos + i+1,26 ].Value = "=SUM(Z"+last_i+":Z"+(pos+i)+")";
				exSheet.Cells[pos + i+1,27 ].Value = "=SUM(AA"+last_i+":AA"+(pos+i)+")";
				exSheet.Cells[pos + i+1,28 ].Value = "=SUM(AB"+last_i+":AB"+(pos+i)+")";
				exSheet.Cells[pos + i+1,29 ].Value = "=SUM(AC"+last_i+":AC"+(pos+i)+")";
				
				exSheet.Cells[pos + i+1,30 ].Value = "=SUM(AD"+last_i+":AD"+(pos+i)+")";
				exSheet.Cells[pos + i+1,31 ].Value = "=SUM(AE"+last_i+":AE"+(pos+i)+")";
				exSheet.Cells[pos + i+1,32 ].Value = "=SUM(AF"+last_i+":AF"+(pos+i)+")";
				exSheet.Cells[pos + i+1,33 ].Value = "=SUM(AG"+last_i+":AG"+(pos+i)+")";
				exSheet.Cells[pos + i+1,34 ].Value = "=SUM(AH"+last_i+":AH"+(pos+i)+")";
				
				exSheet.Cells[pos + i+1,35 ].Value = "=SUM(AI"+last_i+":AI"+(pos+i)+")";
			}			
        }
		//---------
        
		/*int t = pos+i-1 ;
		
		exSheet.Cells[pos + i,  9].Value = "=sum(I8:I"+t+")";		
		exSheet.Cells[pos + i, 10].Value = "=sum(J8:J"+t+")";	
		exSheet.Cells[pos + i, 11].Value = "=sum(K8:K"+t+")";
		exSheet.Cells[pos + i, 12].Value = "=sum(L8:L"+t+")";*/
		
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