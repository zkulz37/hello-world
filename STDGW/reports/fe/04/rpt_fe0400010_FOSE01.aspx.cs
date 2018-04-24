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

public partial class rpt_fe0400010_FOSE01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_fe0400010_FOSE01.xls";
        string TempFile = "../../../system/temp/rpt_fe0400010_FOSE01_" + Session["User_ID"].ToString() + ".xls";
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

		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_fe0400010_FOSE01_1", "'" + Session["User_ID"].ToString() + "'");				
			
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
			
		// SET DATA
		int pos = 7 ;
		int i   = 0  ;		  						
		
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fe0400010_FOSE01_2" , para);

		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet.Cells[pos + i, 1 ].Value = i+1;

			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["prod_date"];
			
			exSheet.Cells[pos + i, 3 ].Value = dtDetail.Rows[i]["hq_sang"];			
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["lon_sang"];			
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["bo_sang"];			
			exSheet.Cells[pos + i, 6 ].Value = dtDetail.Rows[i]["ga_sang"];				
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["ca_sang"];	
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["bp_sang"];	
			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["cr_sang"];	 
			exSheet.Cells[pos + i,10 ].Value = dtDetail.Rows[i]["chao_sang"];		
			exSheet.Cells[pos + i,11 ].Value = dtDetail.Rows[i]["banh_sang"];	 			
			exSheet.Cells[pos + i,12 ].Value = dtDetail.Rows[i]["trung_sang"];	
			exSheet.Cells[pos + i,13 ].Value = dtDetail.Rows[i]["tiec_sang"];
			exSheet.Cells[pos + i,14 ].Value = dtDetail.Rows[i]["dacbiet_sang"];
			exSheet.Cells[pos + i,15 ].Value = dtDetail.Rows[i]["khac_sang"];			
			exSheet.Cells[pos + i,16 ].Value = dtDetail.Rows[i]["total_sang"];
			
			exSheet.Cells[pos + i,17 ].Value = dtDetail.Rows[i]["hq_trua"];	
			exSheet.Cells[pos + i,18 ].Value = dtDetail.Rows[i]["lon_trua"];	 
			exSheet.Cells[pos + i,19 ].Value = dtDetail.Rows[i]["bo_trua"];	
			exSheet.Cells[pos + i,20 ].Value = dtDetail.Rows[i]["ga_trua"];	
			exSheet.Cells[pos + i,21 ].Value = dtDetail.Rows[i]["ca_trua"];	
			exSheet.Cells[pos + i,22 ].Value = dtDetail.Rows[i]["bp_trua"];	
			exSheet.Cells[pos + i,23 ].Value = dtDetail.Rows[i]["cr_trua"];	
			exSheet.Cells[pos + i,24 ].Value = dtDetail.Rows[i]["chao_trua"];	
			exSheet.Cells[pos + i,25 ].Value = dtDetail.Rows[i]["banh_trua"];	
			exSheet.Cells[pos + i,26 ].Value = dtDetail.Rows[i]["trung_trua"];				
			exSheet.Cells[pos + i,27 ].Value = dtDetail.Rows[i]["tiec_trua"];
			exSheet.Cells[pos + i,28 ].Value = dtDetail.Rows[i]["dacbiet_trua"];
			exSheet.Cells[pos + i,29 ].Value = dtDetail.Rows[i]["khac_trua"];			
			exSheet.Cells[pos + i,30 ].Value = dtDetail.Rows[i]["total_trua"];
			
			exSheet.Cells[pos + i,31 ].Value = dtDetail.Rows[i]["hq_chieu"];	
			exSheet.Cells[pos + i,32 ].Value = dtDetail.Rows[i]["lon_chieu"];	
			exSheet.Cells[pos + i,33 ].Value = dtDetail.Rows[i]["bo_chieu"];	
			exSheet.Cells[pos + i,34 ].Value = dtDetail.Rows[i]["ga_chieu"];	
			exSheet.Cells[pos + i,35 ].Value = dtDetail.Rows[i]["ca_chieu"];	
			exSheet.Cells[pos + i,36 ].Value = dtDetail.Rows[i]["bp_chieu"];	
			exSheet.Cells[pos + i,37 ].Value = dtDetail.Rows[i]["cr_chieu"];	
			exSheet.Cells[pos + i,38 ].Value = dtDetail.Rows[i]["chao_chieu"];	
			exSheet.Cells[pos + i,39 ].Value = dtDetail.Rows[i]["banh_chieu"];	
			exSheet.Cells[pos + i,40 ].Value = dtDetail.Rows[i]["trung_chieu"];	
			exSheet.Cells[pos + i,41 ].Value = dtDetail.Rows[i]["tiec_chieu"];	
			exSheet.Cells[pos + i,42 ].Value = dtDetail.Rows[i]["dacbiet_chieu"];
			exSheet.Cells[pos + i,43 ].Value = dtDetail.Rows[i]["khac_chieu"];	
			exSheet.Cells[pos + i,44 ].Value = dtDetail.Rows[i]["total_chieu"];	
			
			exSheet.Cells[pos + i,45 ].Value = dtDetail.Rows[i]["hq_toi"];	
			exSheet.Cells[pos + i,46 ].Value = dtDetail.Rows[i]["lon_toi"];	
			exSheet.Cells[pos + i,47 ].Value = dtDetail.Rows[i]["bo_toi"];	
			exSheet.Cells[pos + i,48 ].Value = dtDetail.Rows[i]["ga_toi"];	
			exSheet.Cells[pos + i,49 ].Value = dtDetail.Rows[i]["ca_toi"];	
			exSheet.Cells[pos + i,50 ].Value = dtDetail.Rows[i]["bp_toi"];	
			exSheet.Cells[pos + i,51 ].Value = dtDetail.Rows[i]["cr_toi"];	
			exSheet.Cells[pos + i,52 ].Value = dtDetail.Rows[i]["chao_toi"];	
			exSheet.Cells[pos + i,53 ].Value = dtDetail.Rows[i]["banh_toi"];	
			exSheet.Cells[pos + i,54 ].Value = dtDetail.Rows[i]["trung_toi"];	
			exSheet.Cells[pos + i,55 ].Value = dtDetail.Rows[i]["tiec_toi"];
			exSheet.Cells[pos + i,56 ].Value = dtDetail.Rows[i]["dacbiet_toi"];
			exSheet.Cells[pos + i,57 ].Value = dtDetail.Rows[i]["khac_toi"];			
			exSheet.Cells[pos + i,58 ].Value = dtDetail.Rows[i]["total_toi"];
			
			exSheet.Cells[pos + i,59 ].Value = dtDetail.Rows[i]["hq_phu"];	
			exSheet.Cells[pos + i,60 ].Value = dtDetail.Rows[i]["lon_phu"];	
			exSheet.Cells[pos + i,61 ].Value = dtDetail.Rows[i]["bo_phu"];	
			exSheet.Cells[pos + i,62 ].Value = dtDetail.Rows[i]["ga_phu"];	
			exSheet.Cells[pos + i,63 ].Value = dtDetail.Rows[i]["ca_phu"];	
			exSheet.Cells[pos + i,64 ].Value = dtDetail.Rows[i]["bp_phu"];	
			exSheet.Cells[pos + i,65 ].Value = dtDetail.Rows[i]["cr_phu"];	
			exSheet.Cells[pos + i,66 ].Value = dtDetail.Rows[i]["chao_phu"];	
			exSheet.Cells[pos + i,67 ].Value = dtDetail.Rows[i]["banh_phu"];	
			exSheet.Cells[pos + i,68 ].Value = dtDetail.Rows[i]["trung_phu"];	
			exSheet.Cells[pos + i,69 ].Value = dtDetail.Rows[i]["tiec_phu"];
			exSheet.Cells[pos + i,70 ].Value = dtDetail.Rows[i]["dacbiet_phu"];
			exSheet.Cells[pos + i,71 ].Value = dtDetail.Rows[i]["khac_phu"];			
			exSheet.Cells[pos + i,72 ].Value = dtDetail.Rows[i]["total_phu"];			
			
			exSheet.Cells[pos + i,73 ].Value = dtDetail.Rows[i]["hq_total"];	
			exSheet.Cells[pos + i,74 ].Value = dtDetail.Rows[i]["lon_total"];	
			exSheet.Cells[pos + i,75 ].Value = dtDetail.Rows[i]["bo_total"];	
			exSheet.Cells[pos + i,76 ].Value = dtDetail.Rows[i]["ga_total"];	
			exSheet.Cells[pos + i,77 ].Value = dtDetail.Rows[i]["ca_total"];	
			exSheet.Cells[pos + i,78 ].Value = dtDetail.Rows[i]["bp_total"];	
			exSheet.Cells[pos + i,79 ].Value = dtDetail.Rows[i]["cr_total"];	
			exSheet.Cells[pos + i,80 ].Value = dtDetail.Rows[i]["chao_total"];	
			exSheet.Cells[pos + i,81 ].Value = dtDetail.Rows[i]["banh_total"];
			exSheet.Cells[pos + i,82 ].Value = dtDetail.Rows[i]["trung_total"];
			exSheet.Cells[pos + i,83 ].Value = dtDetail.Rows[i]["tiec_total"];
			exSheet.Cells[pos + i,84 ].Value = dtDetail.Rows[i]["dacbiet_total"];
			exSheet.Cells[pos + i,85 ].Value = dtDetail.Rows[i]["khac_total"];
			exSheet.Cells[pos + i,86 ].Value = dtDetail.Rows[i]["total_total"];

			
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
			exSheet.Cells[pos + i,36 ].Value = "=SUM(AJ7:AJ"+(pos+i-1)+")";
			exSheet.Cells[pos + i,37 ].Value = "=SUM(AK7:AK"+(pos+i-1)+")";
			exSheet.Cells[pos + i,38 ].Value = "=SUM(AL7:AL"+(pos+i-1)+")";
			exSheet.Cells[pos + i,39 ].Value = "=SUM(AM7:AM"+(pos+i-1)+")";
			exSheet.Cells[pos + i,40 ].Value = "=SUM(AN7:AN"+(pos+i-1)+")";
			exSheet.Cells[pos + i,41 ].Value = "=SUM(AO7:AO"+(pos+i-1)+")";
			exSheet.Cells[pos + i,42 ].Value = "=SUM(AP7:AP"+(pos+i-1)+")";
			exSheet.Cells[pos + i,43 ].Value = "=SUM(AQ7:AQ"+(pos+i-1)+")";
			exSheet.Cells[pos + i,44 ].Value = "=SUM(AR7:AR"+(pos+i-1)+")";
			exSheet.Cells[pos + i,45 ].Value = "=SUM(AS7:AS"+(pos+i-1)+")";
			exSheet.Cells[pos + i,46 ].Value = "=SUM(AT7:AT"+(pos+i-1)+")";
			exSheet.Cells[pos + i,47 ].Value = "=SUM(AU7:AU"+(pos+i-1)+")";
			exSheet.Cells[pos + i,48 ].Value = "=SUM(AV7:AV"+(pos+i-1)+")";
			exSheet.Cells[pos + i,49 ].Value = "=SUM(AW7:AW"+(pos+i-1)+")";			
			exSheet.Cells[pos + i,50 ].Value = "=SUM(AX7:AX"+(pos+i-1)+")";
			exSheet.Cells[pos + i,51 ].Value = "=SUM(AY7:AY"+(pos+i-1)+")";
			exSheet.Cells[pos + i,52 ].Value = "=SUM(AZ7:AZ"+(pos+i-1)+")";
			exSheet.Cells[pos + i,53 ].Value = "=SUM(BA7:BA"+(pos+i-1)+")";
			exSheet.Cells[pos + i,54 ].Value = "=SUM(BB7:BB"+(pos+i-1)+")";
			exSheet.Cells[pos + i,55 ].Value = "=SUM(BC7:BC"+(pos+i-1)+")";
			exSheet.Cells[pos + i,56 ].Value = "=SUM(BD7:BD"+(pos+i-1)+")";
			exSheet.Cells[pos + i,57 ].Value = "=SUM(BE7:BE"+(pos+i-1)+")";
			exSheet.Cells[pos + i,58 ].Value = "=SUM(BF7:BF"+(pos+i-1)+")";
			exSheet.Cells[pos + i,59 ].Value = "=SUM(BG7:BG"+(pos+i-1)+")";
			exSheet.Cells[pos + i,60 ].Value = "=SUM(BH7:BH"+(pos+i-1)+")";
			exSheet.Cells[pos + i,61 ].Value = "=SUM(BI7:BI"+(pos+i-1)+")";
			exSheet.Cells[pos + i,62 ].Value = "=SUM(BJ7:BJ"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,63 ].Value = "=SUM(BK7:BK"+(pos+i-1)+")";
			exSheet.Cells[pos + i,64 ].Value = "=SUM(BL7:BL"+(pos+i-1)+")";
			exSheet.Cells[pos + i,65 ].Value = "=SUM(BM7:BM"+(pos+i-1)+")";
			exSheet.Cells[pos + i,66 ].Value = "=SUM(BN7:BN"+(pos+i-1)+")";
			exSheet.Cells[pos + i,67 ].Value = "=SUM(BO7:BO"+(pos+i-1)+")";
			exSheet.Cells[pos + i,68 ].Value = "=SUM(BP7:BP"+(pos+i-1)+")";
			exSheet.Cells[pos + i,69 ].Value = "=SUM(BQ7:BQ"+(pos+i-1)+")";
			exSheet.Cells[pos + i,70 ].Value = "=SUM(BR7:BR"+(pos+i-1)+")";
			exSheet.Cells[pos + i,71 ].Value = "=SUM(BS7:BS"+(pos+i-1)+")";
			exSheet.Cells[pos + i,72 ].Value = "=SUM(BT7:BT"+(pos+i-1)+")";
			exSheet.Cells[pos + i,73 ].Value = "=SUM(BU7:BU"+(pos+i-1)+")";
			exSheet.Cells[pos + i,74 ].Value = "=SUM(BV7:BV"+(pos+i-1)+")";
			exSheet.Cells[pos + i,75 ].Value = "=SUM(BW7:BW"+(pos+i-1)+")";	 
			exSheet.Cells[pos + i,76 ].Value = "=SUM(BX7:BX"+(pos+i-1)+")";	 
			exSheet.Cells[pos + i,77 ].Value = "=SUM(BY7:BY"+(pos+i-1)+")";	 			
			exSheet.Cells[pos + i,78 ].Value = "=SUM(BZ7:BZ"+(pos+i-1)+")";	 
			exSheet.Cells[pos + i,79 ].Value = "=SUM(CA7:CA"+(pos+i-1)+")";	 
			exSheet.Cells[pos + i,80 ].Value = "=SUM(CB7:CB"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,81 ].Value = "=SUM(CC7:CC"+(pos+i-1)+")";				
			exSheet.Cells[pos + i,82 ].Value = "=SUM(CD7:CD"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,83 ].Value = "=SUM(CE7:CE"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,84 ].Value = "=SUM(CF7:CF"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,85 ].Value = "=SUM(CG7:CG"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,86 ].Value = "=SUM(CH7:CH"+(pos+i-1)+")";		
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