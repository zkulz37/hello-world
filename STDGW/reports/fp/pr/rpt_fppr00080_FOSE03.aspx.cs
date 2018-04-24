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

public partial class rpt_fppr00080_FOSE03 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_fppr00080_FOSE03.xls";
        string TempFile = "../../../system/temp/rpt_fppr00080_FOSE03_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);


        //bind data to excel file
		 
        string p_wh_type, p_wh_pk , p_from_dt, p_to_dt ;
        
		p_wh_type 	= Request.QueryString["p_wh_type"];
		p_wh_pk 	= Request.QueryString["p_wh_pk"];
		p_from_dt 	= Request.QueryString["p_from_dt"];
		p_to_dt 	= Request.QueryString["p_to_dt"];
         
        string para = "'" + p_wh_type + "','" + p_wh_pk + "','" + p_from_dt + "','" + p_to_dt + "'";	

		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080_FOSE03_1", "'" + Session["User_ID"].ToString() + "'");				
			
        // MASTER   

		IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

		/***************************************************************************/
        /***************************************************************************/
		/***************************************************************************/ 		
		/***************************************************************************/
		
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;
		
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
		DataTable dtHeader;
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080_FOSE03_2" , para);
	//xSheet.Cells["C10"].Value = para;
		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
		//for (i = 0; i < 1; i++)
        {								
			exSheet.Cells[pos + i, 1 ].Value = i+1;

			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["partner_id"];	
			
			exSheet.Cells[pos + i, 3 ].Value = "=SUM(D"+(pos+i)+":AW"+(pos+i)+")";
			
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["p01"];			
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["p02"];	
			
			exSheet.Cells[pos + i, 6 ].Value = dtDetail.Rows[i]["p03"];	
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["p04"];	
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["p05"];	 
			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["p06"];		
			exSheet.Cells[pos + i,10 ].Value = dtDetail.Rows[i]["p07"];	 			
			exSheet.Cells[pos + i,11 ].Value = dtDetail.Rows[i]["p08"];	
			exSheet.Cells[pos + i,12 ].Value = dtDetail.Rows[i]["p09"];	
	
			exSheet.Cells[pos + i,13 ].Value = dtDetail.Rows[i]["p10"];	 
			exSheet.Cells[pos + i,14 ].Value = dtDetail.Rows[i]["p11"];	
			exSheet.Cells[pos + i,15 ].Value = dtDetail.Rows[i]["p12"];	 

			exSheet.Cells[pos + i,16 ].Value = dtDetail.Rows[i]["p13"];	
			exSheet.Cells[pos + i,17 ].Value = dtDetail.Rows[i]["p14"];	
			exSheet.Cells[pos + i,18 ].Value = dtDetail.Rows[i]["p15"];	
			exSheet.Cells[pos + i,19 ].Value = dtDetail.Rows[i]["p16"];	
			exSheet.Cells[pos + i,20 ].Value = dtDetail.Rows[i]["p17"];	
			exSheet.Cells[pos + i,21 ].Value = dtDetail.Rows[i]["p18"];	
			exSheet.Cells[pos + i,22 ].Value = dtDetail.Rows[i]["p19"];	
			exSheet.Cells[pos + i,23 ].Value = dtDetail.Rows[i]["p20"];	
			
			exSheet.Cells[pos + i,24 ].Value = dtDetail.Rows[i]["p21"];	
			exSheet.Cells[pos + i,25 ].Value = dtDetail.Rows[i]["p22"];	
			exSheet.Cells[pos + i,26 ].Value = dtDetail.Rows[i]["p23"];	
			exSheet.Cells[pos + i,27 ].Value = dtDetail.Rows[i]["p24"];	
			exSheet.Cells[pos + i,28 ].Value = dtDetail.Rows[i]["p25"];	
			exSheet.Cells[pos + i,29 ].Value = dtDetail.Rows[i]["p26"];	
			exSheet.Cells[pos + i,30 ].Value = dtDetail.Rows[i]["p27"];	
			exSheet.Cells[pos + i,31 ].Value = dtDetail.Rows[i]["p28"];	
			exSheet.Cells[pos + i,32 ].Value = dtDetail.Rows[i]["p29"];	
			exSheet.Cells[pos + i,33 ].Value = dtDetail.Rows[i]["p30"];	
			exSheet.Cells[pos + i,34 ].Value = dtDetail.Rows[i]["p31"];	
			exSheet.Cells[pos + i,35 ].Value = dtDetail.Rows[i]["p32"];	
			exSheet.Cells[pos + i,36 ].Value = dtDetail.Rows[i]["p33"];	
			exSheet.Cells[pos + i,37 ].Value = dtDetail.Rows[i]["p34"];	
			exSheet.Cells[pos + i,38 ].Value = dtDetail.Rows[i]["p35"];	
			exSheet.Cells[pos + i,39 ].Value = dtDetail.Rows[i]["p36"];	
			exSheet.Cells[pos + i,40 ].Value = dtDetail.Rows[i]["p37"];	
			exSheet.Cells[pos + i,41 ].Value = dtDetail.Rows[i]["p38"];	
			exSheet.Cells[pos + i,42 ].Value = dtDetail.Rows[i]["p39"];	
			exSheet.Cells[pos + i,43 ].Value = dtDetail.Rows[i]["p40"];	
			exSheet.Cells[pos + i,44 ].Value = dtDetail.Rows[i]["p41"];	
			exSheet.Cells[pos + i,45 ].Value = dtDetail.Rows[i]["p42"];	
			exSheet.Cells[pos + i,46 ].Value = dtDetail.Rows[i]["p43"];	
			exSheet.Cells[pos + i,47 ].Value = dtDetail.Rows[i]["p44"];	
			exSheet.Cells[pos + i,48 ].Value = dtDetail.Rows[i]["p45"];	
			exSheet.Cells[pos + i,49 ].Value = dtDetail.Rows[i]["p46"];	
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
		
		/***************************************************************************/
        /***************************************************************************/
		/***************************************************************************/ 		
		/***************************************************************************/
				
        //Add worksheet
        exSheet = exBook.Worksheets[2];
		
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


		// SET DATA
		pos = 7 ;
		i   = 0 ;		  						
		
		dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080_FOSE03_3" , para);

		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet.Cells[pos + i, 1 ].Value = i+1;

			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["partner_id"];	
			
			exSheet.Cells[pos + i, 3 ].Value = "=SUM(D"+(pos+i)+":AB"+(pos+i)+")";
			
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["p01"];			
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["p02"];	
			
			exSheet.Cells[pos + i, 6 ].Value = dtDetail.Rows[i]["p03"];	
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["p04"];	
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["p05"];	 
			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["p06"];		
			exSheet.Cells[pos + i,10 ].Value = dtDetail.Rows[i]["p07"];	 			
			exSheet.Cells[pos + i,11 ].Value = dtDetail.Rows[i]["p08"];	
			exSheet.Cells[pos + i,12 ].Value = dtDetail.Rows[i]["p09"];	
	
			exSheet.Cells[pos + i,13 ].Value = dtDetail.Rows[i]["p10"];	 
			exSheet.Cells[pos + i,14 ].Value = dtDetail.Rows[i]["p11"];	
			exSheet.Cells[pos + i,15 ].Value = dtDetail.Rows[i]["p12"];	 

			exSheet.Cells[pos + i,16 ].Value = dtDetail.Rows[i]["p13"];	
			exSheet.Cells[pos + i,17 ].Value = dtDetail.Rows[i]["p14"];	
			exSheet.Cells[pos + i,18 ].Value = dtDetail.Rows[i]["p15"];	
			exSheet.Cells[pos + i,19 ].Value = dtDetail.Rows[i]["p16"];	
			exSheet.Cells[pos + i,20 ].Value = dtDetail.Rows[i]["p17"];	
			exSheet.Cells[pos + i,21 ].Value = dtDetail.Rows[i]["p18"];	
			exSheet.Cells[pos + i,22 ].Value = dtDetail.Rows[i]["p19"];	
			exSheet.Cells[pos + i,23 ].Value = dtDetail.Rows[i]["p20"];	
			
			exSheet.Cells[pos + i,24 ].Value = dtDetail.Rows[i]["p21"];	
			exSheet.Cells[pos + i,25 ].Value = dtDetail.Rows[i]["p22"];	
			exSheet.Cells[pos + i,26 ].Value = dtDetail.Rows[i]["p23"];	
			exSheet.Cells[pos + i,27 ].Value = dtDetail.Rows[i]["p24"];	
			exSheet.Cells[pos + i,28 ].Value = dtDetail.Rows[i]["p25"];	
			exSheet.Cells[pos + i,29 ].Value = dtDetail.Rows[i]["p26"];	
			exSheet.Cells[pos + i,30 ].Value = dtDetail.Rows[i]["p27"];	
			
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
		
		/***************************************************************************/
        /***************************************************************************/
		/***************************************************************************/ 		
		/***************************************************************************/		
		
		exSheet = exBook.Worksheets[3];
		
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

		// SET DATA
		pos = 7 ;
		i   = 0 ;		  						
		
		dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080_FOSE03_4" , para);

		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet.Cells[pos + i, 1 ].Value = i+1;

			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["wh_id"];	
			
			exSheet.Cells[pos + i, 3 ].Value = "=SUM(D"+(pos+i)+":AH"+(pos+i)+")";
			
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["p01"];			
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["p02"];	
			
			exSheet.Cells[pos + i, 6 ].Value = dtDetail.Rows[i]["p03"];	
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["p04"];	
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["p05"];	 
			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["p06"];		
			exSheet.Cells[pos + i,10 ].Value = dtDetail.Rows[i]["p07"];	 			
			exSheet.Cells[pos + i,11 ].Value = dtDetail.Rows[i]["p08"];	
			exSheet.Cells[pos + i,12 ].Value = dtDetail.Rows[i]["p09"];	
	
			exSheet.Cells[pos + i,13 ].Value = dtDetail.Rows[i]["p10"];	 
			exSheet.Cells[pos + i,14 ].Value = dtDetail.Rows[i]["p11"];	
			exSheet.Cells[pos + i,15 ].Value = dtDetail.Rows[i]["p12"];	 

			exSheet.Cells[pos + i,16 ].Value = dtDetail.Rows[i]["p13"];	
			exSheet.Cells[pos + i,17 ].Value = dtDetail.Rows[i]["p14"];	
			exSheet.Cells[pos + i,18 ].Value = dtDetail.Rows[i]["p15"];	
			exSheet.Cells[pos + i,19 ].Value = dtDetail.Rows[i]["p16"];	
			exSheet.Cells[pos + i,20 ].Value = dtDetail.Rows[i]["p17"];	
			exSheet.Cells[pos + i,21 ].Value = dtDetail.Rows[i]["p18"];	
			exSheet.Cells[pos + i,22 ].Value = dtDetail.Rows[i]["p19"];	
			exSheet.Cells[pos + i,23 ].Value = dtDetail.Rows[i]["p20"];	
			
			exSheet.Cells[pos + i,24 ].Value = dtDetail.Rows[i]["p21"];	
			exSheet.Cells[pos + i,25 ].Value = dtDetail.Rows[i]["p22"];	
			exSheet.Cells[pos + i,26 ].Value = dtDetail.Rows[i]["p23"];	
			exSheet.Cells[pos + i,27 ].Value = dtDetail.Rows[i]["p24"];	
			exSheet.Cells[pos + i,28 ].Value = dtDetail.Rows[i]["p25"];	
			exSheet.Cells[pos + i,29 ].Value = dtDetail.Rows[i]["p25"];	
			exSheet.Cells[pos + i,30 ].Value = dtDetail.Rows[i]["p25"];	
			exSheet.Cells[pos + i,31 ].Value = dtDetail.Rows[i]["p25"];	
			
        }
		
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
			
			
		/***************************************************************************/
        /***************************************************************************/
		/***************************************************************************/ 		
		/***************************************************************************/
				
        //Add worksheet
        exSheet = exBook.Worksheets[4];
		
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


		// SET DATA
		pos = 7 ;
		i   = 0 ;		  						
		
		dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080_FOSE03_5" , para);
		dtHeader = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080_FOSE03_6" , para);

		for (int idx = 0; idx < dtHeader.Columns.Count; idx++){
			exSheet.Cells[6,8 + idx * 4].Value = dtHeader.Rows[0][idx];
		}
		
		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet.Cells[pos + i, 1 ].Value = i+1;

			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["partner_id"];							
			
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["p01"];			
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["p02"];				
			exSheet.Cells[pos + i, 6 ].Value = "=E"+(pos+i)+"-D"+(pos+i);
			//exSheet.Cells[pos + i, 7 ].Value = "=F"+(pos+i)+"/D"+(pos+i);	
			exSheet.Cells[pos + i, 7 ].Value = (dtDetail.Rows[i]["p02"].ToString() == "")? "=0" : "=F"+(pos+i)+"/D"+(pos+i);	
			
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["p03"];	
			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["p04"];	
			exSheet.Cells[pos + i,10 ].Value = "=I"+(pos+i)+"-H"+(pos+i);
			//exSheet.Cells[pos + i,11 ].Value = "=J"+(pos+i)+"/H"+(pos+i);
			exSheet.Cells[pos + i, 11].Value = (dtDetail.Rows[i]["p04"].ToString() == "")? "=0" : "=J"+(pos+i)+"/H"+(pos+i);
			
			exSheet.Cells[pos + i,12 ].Value = dtDetail.Rows[i]["p05"];	 
			exSheet.Cells[pos + i,13 ].Value = dtDetail.Rows[i]["p06"];	
			exSheet.Cells[pos + i,14 ].Value = "=M"+(pos+i)+"-L"+(pos+i);
			//exSheet.Cells[pos + i,15 ].Value = "=N"+(pos+i)+"/L"+(pos+i);
			exSheet.Cells[pos + i, 15].Value = (dtDetail.Rows[i]["p06"].ToString() == "")? "=0" : "=N"+(pos+i)+"/L"+(pos+i);
			
			exSheet.Cells[pos + i,16 ].Value = dtDetail.Rows[i]["p07"];	 			
			exSheet.Cells[pos + i,17 ].Value = dtDetail.Rows[i]["p08"];	
			exSheet.Cells[pos + i,18 ].Value = "=Q"+(pos+i)+"-P"+(pos+i);
			exSheet.Cells[pos + i,19 ].Value = (dtDetail.Rows[i]["p08"].ToString() == "")? "=0" : "=R"+(pos+i)+"/P"+(pos+i);
			
			exSheet.Cells[pos + i,20 ].Value = dtDetail.Rows[i]["p09"];		
			exSheet.Cells[pos + i,21 ].Value = dtDetail.Rows[i]["p10"];
			exSheet.Cells[pos + i,22 ].Value = "=U"+(pos+i)+"-T"+(pos+i);			
			//exSheet.Cells[pos + i,23 ].Value = "=V"+(pos+i)+"/T"+(pos+i);
			exSheet.Cells[pos + i, 23].Value = (dtDetail.Rows[i]["p10"].ToString() == "")? "=0" : "=V"+(pos+i)+"/T"+(pos+i);
			//----
			exSheet.Cells[pos + i,24 ].Value = dtDetail.Rows[i]["p11"];	
			exSheet.Cells[pos + i,25 ].Value = dtDetail.Rows[i]["p12"];	 
			exSheet.Cells[pos + i,26 ].Value = "=Y"+(pos+i)+"-X"+(pos+i);
			//exSheet.Cells[pos + i,27 ].Value = "=Z"+(pos+i)+"/X"+(pos+i);
			exSheet.Cells[pos + i, 27].Value = (dtDetail.Rows[i]["p12"].ToString() == "")? "=0" : "=Z"+(pos+i)+"/X"+(pos+i);
			//----
			exSheet.Cells[pos + i,28 ].Value = dtDetail.Rows[i]["p13"];	
			exSheet.Cells[pos + i,29 ].Value = dtDetail.Rows[i]["p14"];	
			exSheet.Cells[pos + i,30 ].Value = "=AC"+(pos+i)+"-AB"+(pos+i);
			//exSheet.Cells[pos + i,31 ].Value = "=AD"+(pos+i)+"/AB"+(pos+i);
			exSheet.Cells[pos + i, 31].Value = (dtDetail.Rows[i]["p14"].ToString() == "")? "=0" : "=AD"+(pos+i)+"/AB"+(pos+i);
			//----
			exSheet.Cells[pos + i,32 ].Value = dtDetail.Rows[i]["p15"];	
			exSheet.Cells[pos + i,33 ].Value = dtDetail.Rows[i]["p16"];	
			exSheet.Cells[pos + i,34 ].Value = "=AG"+(pos+i)+"-AF"+(pos+i);
			//exSheet.Cells[pos + i,35 ].Value = "=AH"+(pos+i)+"/AF"+(pos+i);
			exSheet.Cells[pos + i, 35].Value = (dtDetail.Rows[i]["p16"].ToString() == "")? "=0" : "=AH"+(pos+i)+"/AF"+(pos+i);
			//----
			exSheet.Cells[pos + i,36 ].Value = dtDetail.Rows[i]["p17"];	
			exSheet.Cells[pos + i,37 ].Value = dtDetail.Rows[i]["p18"];	
			exSheet.Cells[pos + i,38 ].Value = "=AK"+(pos+i)+"-AJ"+(pos+i);
			//exSheet.Cells[pos + i,39 ].Value = "=AL"+(pos+i)+"/AJ"+(pos+i);
			exSheet.Cells[pos + i, 39].Value = (dtDetail.Rows[i]["p18"].ToString() == "")? "=0" : "=AL"+(pos+i)+"/AJ"+(pos+i);
			//----
			exSheet.Cells[pos + i,40 ].Value = dtDetail.Rows[i]["p19"];	
			exSheet.Cells[pos + i,41 ].Value = dtDetail.Rows[i]["p20"];	
			exSheet.Cells[pos + i,42 ].Value = "=AO"+(pos+i)+"-AN"+(pos+i);
			//exSheet.Cells[pos + i,43 ].Value = "=AP"+(pos+i)+"/AN"+(pos+i);
			exSheet.Cells[pos + i, 43].Value = (dtDetail.Rows[i]["p20"].ToString() == "")? "=0" : "=AP"+(pos+i)+"/AN"+(pos+i);
			//----
			exSheet.Cells[pos + i,44 ].Value = dtDetail.Rows[i]["p21"];	
			exSheet.Cells[pos + i,45 ].Value = dtDetail.Rows[i]["p22"];	
			exSheet.Cells[pos + i,46 ].Value = "=AS"+(pos+i)+"-AR"+(pos+i);
			//exSheet.Cells[pos + i,47 ].Value = "=AT"+(pos+i)+"/AR"+(pos+i);
			exSheet.Cells[pos + i, 47].Value = (dtDetail.Rows[i]["p22"].ToString() == "")? "=0" : "=AT"+(pos+i)+"/AR"+(pos+i);
			//----
			exSheet.Cells[pos + i,48 ].Value = dtDetail.Rows[i]["p23"];	
			exSheet.Cells[pos + i,49 ].Value = dtDetail.Rows[i]["p24"];	
			exSheet.Cells[pos + i,50 ].Value = "=AW"+(pos+i)+"-AV"+(pos+i);
			//exSheet.Cells[pos + i,51 ].Value = "=AX"+(pos+i)+"/AV"+(pos+i);
			exSheet.Cells[pos + i, 51].Value = (dtDetail.Rows[i]["p24"].ToString() == "")? "=0" : "=AX"+(pos+i)+"/AV"+(pos+i);
			//----
			exSheet.Cells[pos + i,52 ].Value = dtDetail.Rows[i]["p25"];	
			exSheet.Cells[pos + i,53 ].Value = dtDetail.Rows[i]["p26"];	
			exSheet.Cells[pos + i,54 ].Value = "=BA"+(pos+i)+"-AZ"+(pos+i);
			//exSheet.Cells[pos + i,55 ].Value = "=BB"+(pos+i)+"/AZ"+(pos+i);
			exSheet.Cells[pos + i, 51].Value = (dtDetail.Rows[i]["p26"].ToString() == "")? "=0" : "=BB"+(pos+i)+"/AZ"+(pos+i);
			//----
			exSheet.Cells[pos + i,56 ].Value = dtDetail.Rows[i]["p27"];	
			exSheet.Cells[pos + i,57 ].Value = dtDetail.Rows[i]["p28"];	
			exSheet.Cells[pos + i,58 ].Value = "=BE"+(pos+i)+"-BD"+(pos+i);
			//exSheet.Cells[pos + i,59 ].Value = "=BF"+(pos+i)+"/BD"+(pos+i);
			exSheet.Cells[pos + i, 59].Value = (dtDetail.Rows[i]["p28"].ToString() == "")? "=0" : "=BF"+(pos+i)+"/BD"+(pos+i);
			//----
			exSheet.Cells[pos + i,60 ].Value = dtDetail.Rows[i]["p29"];	
			exSheet.Cells[pos + i,61 ].Value = dtDetail.Rows[i]["p30"];	
			exSheet.Cells[pos + i,62 ].Value = "=BI"+(pos+i)+"-BH"+(pos+i);
			//exSheet.Cells[pos + i,63 ].Value = "=BJ"+(pos+i)+"/BH"+(pos+i);
			exSheet.Cells[pos + i, 63].Value = (dtDetail.Rows[i]["p30"].ToString() == "")? "=0" : "=BJ"+(pos+i)+"/BH"+(pos+i);
			//----
			exSheet.Cells[pos + i,64 ].Value = dtDetail.Rows[i]["p31"];	
			exSheet.Cells[pos + i,65 ].Value = dtDetail.Rows[i]["p32"];	
			exSheet.Cells[pos + i,66 ].Value = "=BM"+(pos+i)+"-BL"+(pos+i);	
			//exSheet.Cells[pos + i,67 ].Value = "=BN"+(pos+i)+"/BL"+(pos+i);
			exSheet.Cells[pos + i, 67].Value = (dtDetail.Rows[i]["p32"].ToString() == "")? "=0" : "=BN"+(pos+i)+"/BL"+(pos+i);
			//----
			exSheet.Cells[pos + i,68 ].Value = dtDetail.Rows[i]["p33"];	
			exSheet.Cells[pos + i,69 ].Value = dtDetail.Rows[i]["p34"];	
			exSheet.Cells[pos + i,70 ].Value = "=BQ"+(pos+i)+"-BP"+(pos+i);
			//exSheet.Cells[pos + i,71 ].Value = "=BR"+(pos+i)+"/BP"+(pos+i);
			exSheet.Cells[pos + i, 71].Value = (dtDetail.Rows[i]["p34"].ToString() == "")? "=0" : "=BR"+(pos+i)+"/BP"+(pos+i);
			//----
			exSheet.Cells[pos + i,72 ].Value = dtDetail.Rows[i]["p35"];	
			exSheet.Cells[pos + i,73 ].Value = dtDetail.Rows[i]["p36"];	
			exSheet.Cells[pos + i,74 ].Value = "=BU"+(pos+i)+"-BT"+(pos+i);
			//exSheet.Cells[pos + i,75 ].Value = "=BV"+(pos+i)+"/BT"+(pos+i);
			exSheet.Cells[pos + i, 75].Value = (dtDetail.Rows[i]["p36"].ToString() == "")? "=0" : "=BV"+(pos+i)+"/BT"+(pos+i);
			//----
			exSheet.Cells[pos + i,76 ].Value = dtDetail.Rows[i]["p37"];	
			exSheet.Cells[pos + i,77 ].Value = dtDetail.Rows[i]["p38"];	
			exSheet.Cells[pos + i,78 ].Value = "=BY"+(pos+i)+"-BX"+(pos+i);
			//exSheet.Cells[pos + i,79 ].Value = "=BZ"+(pos+i)+"/BX"+(pos+i);
			exSheet.Cells[pos + i, 79].Value = (dtDetail.Rows[i]["p38"].ToString() == "")? "=0" : "=BZ"+(pos+i)+"/BX"+(pos+i);
			//----
			exSheet.Cells[pos + i,80 ].Value = dtDetail.Rows[i]["p39"];	
			exSheet.Cells[pos + i,81 ].Value = dtDetail.Rows[i]["p40"];	
			exSheet.Cells[pos + i,82 ].Value = "=CC"+(pos+i)+"-CB"+(pos+i);
			//exSheet.Cells[pos + i,83 ].Value = "=CD"+(pos+i)+"/CB"+(pos+i);
			exSheet.Cells[pos + i, 83].Value = (dtDetail.Rows[i]["p40"].ToString() == "")? "=0" : "=CD"+(pos+i)+"/CB"+(pos+i);
			//----
			exSheet.Cells[pos + i,84 ].Value = dtDetail.Rows[i]["p41"];	
			exSheet.Cells[pos + i,85 ].Value = dtDetail.Rows[i]["p42"];	
			exSheet.Cells[pos + i,86 ].Value = "=CG"+(pos+i)+"-CF"+(pos+i);
			//exSheet.Cells[pos + i,87 ].Value = "=CH"+(pos+i)+"/CF"+(pos+i);
			exSheet.Cells[pos + i, 87].Value = (dtDetail.Rows[i]["p42"].ToString() == "")? "=0" : "=CH"+(pos+i)+"/CF"+(pos+i);
			//----
			exSheet.Cells[pos + i,88 ].Value = dtDetail.Rows[i]["p43"];	
			exSheet.Cells[pos + i,89 ].Value = dtDetail.Rows[i]["p44"];	
			exSheet.Cells[pos + i,90 ].Value = "=CK"+(pos+i)+"-CJ"+(pos+i);
			//exSheet.Cells[pos + i,91 ].Value = "=CL"+(pos+i)+"/CJ"+(pos+i);
			exSheet.Cells[pos + i, 91].Value = (dtDetail.Rows[i]["p44"].ToString() == "")? "=0" : "=CL"+(pos+i)+"/CJ"+(pos+i);
			//----
			exSheet.Cells[pos + i,92 ].Value = dtDetail.Rows[i]["p45"];	
			exSheet.Cells[pos + i,93 ].Value = dtDetail.Rows[i]["p46"];	
			exSheet.Cells[pos + i,94 ].Value = "=CO"+(pos+i)+"-CN"+(pos+i);
			//exSheet.Cells[pos + i,95 ].Value = "=CP"+(pos+i)+"/CN"+(pos+i);
			exSheet.Cells[pos + i, 95].Value = (dtDetail.Rows[i]["p46"].ToString() == "")? "=0" : "=CP"+(pos+i)+"/CN"+(pos+i);
			//----
			exSheet.Cells[pos + i,96 ].Value = dtDetail.Rows[i]["p47"];	
			exSheet.Cells[pos + i,97 ].Value = dtDetail.Rows[i]["p48"];	
			exSheet.Cells[pos + i,98 ].Value = "=CS"+(pos+i)+"-CR"+(pos+i);
			//exSheet.Cells[pos + i,99 ].Value = "=CT"+(pos+i)+"/CR"+(pos+i);
			exSheet.Cells[pos + i, 99].Value = (dtDetail.Rows[i]["p48"].ToString() == "")? "=0" : "=CT"+(pos+i)+"/CR"+(pos+i);
			//----
			exSheet.Cells[pos + i,100 ].Value = dtDetail.Rows[i]["p49"];	
			exSheet.Cells[pos + i,101 ].Value = dtDetail.Rows[i]["p50"];	
			exSheet.Cells[pos + i,102 ].Value = "=CW"+(pos+i)+"-CV"+(pos+i);
			//exSheet.Cells[pos + i,103 ].Value = "=CX"+(pos+i)+"/CV"+(pos+i);
			exSheet.Cells[pos + i,103].Value = (dtDetail.Rows[i]["p50"].ToString() == "")? "=0" : "=CX"+(pos+i)+"/CV"+(pos+i);
			//----
			exSheet.Cells[pos + i,104 ].Value = dtDetail.Rows[i]["p51"];	
			exSheet.Cells[pos + i,105 ].Value = dtDetail.Rows[i]["p52"];	
			exSheet.Cells[pos + i,106 ].Value = "=DA"+(pos+i)+"-CZ"+(pos+i);
			//exSheet.Cells[pos + i,107 ].Value = "=DB"+(pos+i)+"/CZ"+(pos+i);
			exSheet.Cells[pos + i,107].Value = (dtDetail.Rows[i]["p52"].ToString() == "")? "=0" : "=DB"+(pos+i)+"/CZ"+(pos+i);
			//----
			exSheet.Cells[pos + i,108 ].Value = dtDetail.Rows[i]["p53"];	
			exSheet.Cells[pos + i,109 ].Value = dtDetail.Rows[i]["p54"];	
			exSheet.Cells[pos + i,110 ].Value = "=DE"+(pos+i)+"-DD"+(pos+i);
			//exSheet.Cells[pos + i,111 ].Value = "=DF"+(pos+i)+"/DD"+(pos+i);					
			exSheet.Cells[pos + i,111].Value = (dtDetail.Rows[i]["p54"].ToString() == "")? "=0" : "=DF"+(pos+i)+"/DD"+(pos+i);
        }
		//---------
						
			exSheet.Cells[pos + i, 4 ].Value = "=SUM(D7:D"+(pos+i-1)+")";	
			exSheet.Cells[pos + i, 5 ].Value = "=SUM(E7:E"+(pos+i-1)+")";			
			exSheet.Cells[pos + i, 6 ].Value = "=SUM(F7:F"+(pos+i-1)+")";
			
			exSheet.Cells[pos + i, 8 ].Value = "=SUM(H7:H"+(pos+i-1)+")";
			exSheet.Cells[pos + i, 9 ].Value = "=SUM(I7:I"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,10 ].Value = "=SUM(J7:J"+(pos+i-1)+")";		
			
			exSheet.Cells[pos + i,12 ].Value = "=SUM(L7:L"+(pos+i-1)+")";				
			exSheet.Cells[pos + i,13 ].Value = "=SUM(M7:M"+(pos+i-1)+")"; 
			exSheet.Cells[pos + i,14 ].Value = "=SUM(N7:N"+(pos+i-1)+")";
			
			exSheet.Cells[pos + i,16 ].Value = "=SUM(P7:P"+(pos+i-1)+")";
			exSheet.Cells[pos + i,17 ].Value = "=SUM(Q7:Q"+(pos+i-1)+")";
			exSheet.Cells[pos + i,18 ].Value = "=SUM(R7:R"+(pos+i-1)+")";	
			
			exSheet.Cells[pos + i,20 ].Value = "=SUM(T7:T"+(pos+i-1)+")";		
			exSheet.Cells[pos + i,21 ].Value = "=SUM(U7:U"+(pos+i-1)+")";
			exSheet.Cells[pos + i,22 ].Value = "=SUM(V7:V"+(pos+i-1)+")";	
			
			exSheet.Cells[pos + i,24 ].Value = "=SUM(X7:X"+(pos+i-1)+")";
			exSheet.Cells[pos + i,25 ].Value = "=SUM(Y7:Y"+(pos+i-1)+")";
			exSheet.Cells[pos + i,26 ].Value = "=SUM(Z7:Z"+(pos+i-1)+")";
			
			exSheet.Cells[pos + i,28 ].Value = "=SUM(AB7:AB"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,29 ].Value = "=SUM(AC7:AC"+(pos+i-1)+")";
			exSheet.Cells[pos + i,30 ].Value = "=SUM(AD7:AC"+(pos+i-1)+")";
			
			exSheet.Cells[pos + i,32 ].Value = "=SUM(AF7:AF"+(pos+i-1)+")";
			exSheet.Cells[pos + i,33 ].Value = "=SUM(AG7:AG"+(pos+i-1)+")";
			exSheet.Cells[pos + i,34 ].Value = "=SUM(AH7:AH"+(pos+i-1)+")";
			
			exSheet.Cells[pos + i,36 ].Value = "=SUM(AJ7:AJ"+(pos+i-1)+")";
			exSheet.Cells[pos + i,37 ].Value = "=SUM(AK7:AK"+(pos+i-1)+")";
			exSheet.Cells[pos + i,38 ].Value = "=SUM(AL7:AL"+(pos+i-1)+")";			
			
		    exSheet.Cells[pos + i,40 ].Value = "=SUM(AN7:AN"+(pos+i-1)+")";
		    exSheet.Cells[pos + i,41 ].Value = "=SUM(AO7:AO"+(pos+i-1)+")";
		    exSheet.Cells[pos + i,42 ].Value = "=SUM(AP7:AP"+(pos+i-1)+")";
			
			exSheet.Cells[pos + i,44 ].Value = "=SUM(AR7:AR"+(pos+i-1)+")";
			exSheet.Cells[pos + i,45 ].Value = "=SUM(AS7:AS"+(pos+i-1)+")";
			exSheet.Cells[pos + i,46 ].Value = "=SUM(AT7:AT"+(pos+i-1)+")";
			
			exSheet.Cells[pos + i,48 ].Value = "=SUM(AV7:AV"+(pos+i-1)+")";
			exSheet.Cells[pos + i,49 ].Value = "=SUM(AW7:AW"+(pos+i-1)+")";
			exSheet.Cells[pos + i,50 ].Value = "=SUM(AX7:AZ"+(pos+i-1)+")";
			
			exSheet.Cells[pos + i,52 ].Value = "=SUM(AZ7:AZ"+(pos+i-1)+")";					
			exSheet.Cells[pos + i,53 ].Value = "=SUM(BA7:BA"+(pos+i-1)+")";
			exSheet.Cells[pos + i,54 ].Value = "=SUM(BB7:BB"+(pos+i-1)+")";
			
			exSheet.Cells[pos + i,56 ].Value = "=SUM(BD7:BD"+(pos+i-1)+")";
			exSheet.Cells[pos + i,57 ].Value = "=SUM(BE7:BE"+(pos+i-1)+")";
			exSheet.Cells[pos + i,58 ].Value = "=SUM(BF7:BF"+(pos+i-1)+")";		
			
			exSheet.Cells[pos + i,60 ].Value = "=SUM(BH7:BH"+(pos+i-1)+")";
			exSheet.Cells[pos + i,61 ].Value = "=SUM(BI7:BI"+(pos+i-1)+")";
			exSheet.Cells[pos + i,62 ].Value = "=SUM(BJ7:BJ"+(pos+i-1)+")";
			
			exSheet.Cells[pos + i,64 ].Value = "=SUM(BL7:BL"+(pos+i-1)+")";
			exSheet.Cells[pos + i,65 ].Value = "=SUM(BM7:BM"+(pos+i-1)+")";
			exSheet.Cells[pos + i,66 ].Value = "=SUM(BN7:BN"+(pos+i-1)+")";	
			
			exSheet.Cells[pos + i,68 ].Value = "=SUM(BP7:BP"+(pos+i-1)+")";
			exSheet.Cells[pos + i,69 ].Value = "=SUM(BQ7:BQ"+(pos+i-1)+")";				
			exSheet.Cells[pos + i,70 ].Value = "=SUM(BR7:BR"+(pos+i-1)+")";
			
			exSheet.Cells[pos + i,72 ].Value = "=SUM(BT7:BT"+(pos+i-1)+")";
			exSheet.Cells[pos + i,73 ].Value = "=SUM(BU7:BU"+(pos+i-1)+")";
			exSheet.Cells[pos + i,74 ].Value = "=SUM(BV7:BV"+(pos+i-1)+")";

			exSheet.Cells[pos + i,76 ].Value = "=SUM(BX7:BX"+(pos+i-1)+")";
			exSheet.Cells[pos + i,77 ].Value = "=SUM(BY7:BY"+(pos+i-1)+")";
			exSheet.Cells[pos + i,78 ].Value = "=SUM(BZ7:BZ"+(pos+i-1)+")";	
			
			exSheet.Cells[pos + i,80 ].Value = "=SUM(CB7:CB"+(pos+i-1)+")";
			exSheet.Cells[pos + i,81 ].Value = "=SUM(CC7:CC"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,82 ].Value = "=SUM(CD7:CD"+(pos+i-1)+")";		
			
			exSheet.Cells[pos + i,84 ].Value = "=SUM(CF7:CF"+(pos+i-1)+")";
			exSheet.Cells[pos + i,85 ].Value = "=SUM(CG7:CG"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,86 ].Value = "=SUM(CH7:CH"+(pos+i-1)+")";	
			
			exSheet.Cells[pos + i,88 ].Value = "=SUM(CJ7:CJ"+(pos+i-1)+")";
			exSheet.Cells[pos + i,89 ].Value = "=SUM(CK7:CK"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,90 ].Value = "=SUM(CL7:CL"+(pos+i-1)+")";	
			
			exSheet.Cells[pos + i,92 ].Value = "=SUM(CN7:CN"+(pos+i-1)+")";
			exSheet.Cells[pos + i,93 ].Value = "=SUM(CO7:CO"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,94 ].Value = "=SUM(CP7:CP"+(pos+i-1)+")";	
			
			exSheet.Cells[pos + i,96 ].Value = "=SUM(CR7:CR"+(pos+i-1)+")";
			exSheet.Cells[pos + i,97 ].Value = "=SUM(CS7:CS"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,98 ].Value = "=SUM(CT7:CT"+(pos+i-1)+")";	
			
			exSheet.Cells[pos + i,100 ].Value = "=SUM(CV7:CV"+(pos+i-1)+")";
			exSheet.Cells[pos + i,101 ].Value = "=SUM(CW7:CW"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,102 ].Value = "=SUM(CX7:CX"+(pos+i-1)+")";		
			
			exSheet.Cells[pos + i,104 ].Value = "=SUM(CZ7:CZ"+(pos+i-1)+")";
			exSheet.Cells[pos + i,105 ].Value = "=SUM(DA7:DA"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,106 ].Value = "=SUM(DB7:DB"+(pos+i-1)+")";
			
			exSheet.Cells[pos + i,108 ].Value = "=SUM(DD7:DD"+(pos+i-1)+")";
			exSheet.Cells[pos + i,109 ].Value = "=SUM(DE7:DE"+(pos+i-1)+")";	
			exSheet.Cells[pos + i,110 ].Value = "=SUM(DF7:DF"+(pos+i-1)+")";						
		
		/***************************************************************************/
        /***************************************************************************/
		/***************************************************************************/ 		
		/***************************************************************************/
		
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