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

public partial class rpt_fppr00080_fose08 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_fppr00080_fose08.xls";
        string TempFile = "../../../system/temp/rpt_fppr00080_fose08_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		 
        string 	p_from_dt = Request.QueryString["p_from_dt"];
        string 	p_to_dt = Request.QueryString["p_to_dt"];
         
        string para = "'" + p_from_dt + "','" + p_to_dt + "'";	
      

		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080_fose08",para);				
			
        // MASTER   

		//--set-----DataBind--in---Master---
       
		
		//tong tin master
		 
        // END MASTER
		
		// INSERT ROWS
		 
		
			
			
		// SET DATA
							
		
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080_fose08" , para);
		if(dtDetail.Rows.Count>0)
		{
		
			exSheet.Cells[2,5 ].Value = dtDetail.Rows[0]["p1"];
			exSheet.Cells[2,7 ].Value = dtDetail.Rows[0]["p2"];
			exSheet.Cells[2,9 ].Value = dtDetail.Rows[0]["p3"];
			exSheet.Cells[2,11 ].Value = dtDetail.Rows[0]["p4"];
			exSheet.Cells[2,13 ].Value = dtDetail.Rows[0]["p5"];
			exSheet.Cells[2,15 ].Value = dtDetail.Rows[0]["p6"];
			exSheet.Cells[2,17 ].Value = dtDetail.Rows[0]["p7"];
			exSheet.Cells[2,19 ].Value = dtDetail.Rows[0]["p8"];
			exSheet.Cells[2,21 ].Value = dtDetail.Rows[0]["p9"];
			exSheet.Cells[2,23 ].Value = dtDetail.Rows[0]["p10"];
			exSheet.Cells[2,25 ].Value = dtDetail.Rows[0]["p11"];
			exSheet.Cells[2,27 ].Value = dtDetail.Rows[0]["p12"];
			exSheet.Cells[2,29 ].Value = dtDetail.Rows[0]["p13"];
			exSheet.Cells[2,31 ].Value = dtDetail.Rows[0]["p14"];
			exSheet.Cells[2,33 ].Value = dtDetail.Rows[0]["p15"];
			exSheet.Cells[2,35 ].Value = dtDetail.Rows[0]["p16"];
			exSheet.Cells[2,37 ].Value = dtDetail.Rows[0]["p17"];
			exSheet.Cells[2,39 ].Value = dtDetail.Rows[0]["p18"];
			exSheet.Cells[2,41 ].Value = dtDetail.Rows[0]["p19"];
			exSheet.Cells[2,43 ].Value = dtDetail.Rows[0]["p20"];
			exSheet.Cells[2,45 ].Value = dtDetail.Rows[0]["p21"];
			exSheet.Cells[2,47 ].Value = dtDetail.Rows[0]["p22"];
			exSheet.Cells[2,49 ].Value = dtDetail.Rows[0]["p23"];
			exSheet.Cells[2,51 ].Value = dtDetail.Rows[0]["p24"];
			exSheet.Cells[2,53 ].Value = dtDetail.Rows[0]["p25"];
			exSheet.Cells[2,55 ].Value = dtDetail.Rows[0]["p26"];
			exSheet.Cells[2,57 ].Value = dtDetail.Rows[0]["p27"];
			exSheet.Cells[2,59 ].Value = dtDetail.Rows[0]["p28"];
			exSheet.Cells[2,61 ].Value = dtDetail.Rows[0]["p29"];
			exSheet.Cells[2,63 ].Value = dtDetail.Rows[0]["p30"];
			exSheet.Cells[2,65 ].Value = dtDetail.Rows[0]["p31"];
			exSheet.Cells[2,67 ].Value = dtDetail.Rows[0]["p32"];
			exSheet.Cells[2,69 ].Value = dtDetail.Rows[0]["p33"];
			exSheet.Cells[2,71 ].Value = dtDetail.Rows[0]["p34"];
			exSheet.Cells[2,73 ].Value = dtDetail.Rows[0]["p35"];
			exSheet.Cells[2,75 ].Value = dtDetail.Rows[0]["p36"];
			exSheet.Cells[2,77 ].Value = dtDetail.Rows[0]["p37"];
			exSheet.Cells[2,79 ].Value = dtDetail.Rows[0]["p38"];
			exSheet.Cells[2,81 ].Value = dtDetail.Rows[0]["p39"];
			exSheet.Cells[2,83 ].Value = dtDetail.Rows[0]["p40"];
			exSheet.Cells[2,85 ].Value = dtDetail.Rows[0]["p41"];
			exSheet.Cells[2,87 ].Value = dtDetail.Rows[0]["p42"];
			exSheet.Cells[2,89 ].Value = dtDetail.Rows[0]["p43"];
			exSheet.Cells[2,91 ].Value = dtDetail.Rows[0]["p44"];
			exSheet.Cells[2,93 ].Value = dtDetail.Rows[0]["p45"];
			exSheet.Cells[2,95 ].Value = dtDetail.Rows[0]["p46"];			
			exSheet.Cells[2,97 ].Value = dtDetail.Rows[0]["p47"];
			exSheet.Cells[2,99 ].Value = dtDetail.Rows[0]["p48"];
			exSheet.Cells[2,101 ].Value = dtDetail.Rows[0]["p49"];
			exSheet.Cells[2,103].Value = dtDetail.Rows[0]["p50"];
			exSheet.Cells[2,105].Value = dtDetail.Rows[0]["p51"];
			exSheet.Cells[2,107].Value = dtDetail.Rows[0]["p52"];
			exSheet.Cells[2,109].Value = dtDetail.Rows[0]["p53"];
			exSheet.Cells[2,111 ].Value = dtDetail.Rows[0]["p54"];
			exSheet.Cells[2,113].Value = dtDetail.Rows[0]["p55"];
			exSheet.Cells[2,115].Value = dtDetail.Rows[0]["p56"];
			exSheet.Cells[2,117].Value = dtDetail.Rows[0]["p57"];
			exSheet.Cells[2,119].Value = dtDetail.Rows[0]["p58"];
			exSheet.Cells[2,121].Value = dtDetail.Rows[0]["p59"];
			exSheet.Cells[2,123].Value = dtDetail.Rows[0]["p60"];
		}
		
		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		  int pos =7 ;
		int i   = 0  ;	
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet.Cells[pos + i, 1 ].Value = i+1;

			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["item_name"];	
			exSheet.Cells[pos + i, 3 ].Value = dtDetail.Rows[i]["total_qty"];
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["total_amt"];	
			
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["q1"];				
			exSheet.Cells[pos + i, 6 ].Value = dtDetail.Rows[i]["a1"];	
			
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["q2"];	 
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["a2"];				
			
			exSheet.Cells[pos + i,9 ].Value = dtDetail.Rows[i]["q3"];	
			exSheet.Cells[pos + i,10 ].Value = dtDetail.Rows[i]["a3"];			
						
			exSheet.Cells[pos + i,11 ].Value = dtDetail.Rows[i]["q4"];	
			exSheet.Cells[pos + i,12 ].Value = dtDetail.Rows[i]["a4"];				
			 
			exSheet.Cells[pos + i,13 ].Value = dtDetail.Rows[i]["q5"];	
			exSheet.Cells[pos + i,14 ].Value = dtDetail.Rows[i]["a5"];			
			
			exSheet.Cells[pos + i,15 ].Value = dtDetail.Rows[i]["q6"];	
			exSheet.Cells[pos + i,16 ].Value = dtDetail.Rows[i]["a6"];			
			
			exSheet.Cells[pos + i,17 ].Value = dtDetail.Rows[i]["q7"];	
			exSheet.Cells[pos + i,18 ].Value = dtDetail.Rows[i]["a7"];				
			
			exSheet.Cells[pos + i,19 ].Value = dtDetail.Rows[i]["q8"];	
			exSheet.Cells[pos + i,20 ].Value = dtDetail.Rows[i]["a8"];	
						
			exSheet.Cells[pos + i,21 ].Value = dtDetail.Rows[i]["q9"];	
			exSheet.Cells[pos + i,22 ].Value = dtDetail.Rows[i]["a9"];	
						
			exSheet.Cells[pos + i,23 ].Value = dtDetail.Rows[i]["q10"];	
			exSheet.Cells[pos + i,24 ].Value = dtDetail.Rows[i]["a10"];				
			
			exSheet.Cells[pos + i,25 ].Value = dtDetail.Rows[i]["q11"];	
			exSheet.Cells[pos + i,26 ].Value = dtDetail.Rows[i]["a11"];				
			
			exSheet.Cells[pos + i,27 ].Value = dtDetail.Rows[i]["q12"];	
			exSheet.Cells[pos + i,28 ].Value = dtDetail.Rows[i]["a12"];	
		
			exSheet.Cells[pos + i,29 ].Value = dtDetail.Rows[i]["q13"];	
			exSheet.Cells[pos + i,30 ].Value = dtDetail.Rows[i]["a13"];	
			
			
			exSheet.Cells[pos + i,31 ].Value = dtDetail.Rows[i]["q14"];	
			exSheet.Cells[pos + i,32 ].Value = dtDetail.Rows[i]["a14"];	
			
			exSheet.Cells[pos + i,33 ].Value = dtDetail.Rows[i]["q15"];	
			exSheet.Cells[pos + i,34 ].Value = dtDetail.Rows[i]["a15"];	
			
			exSheet.Cells[pos + i,35 ].Value = dtDetail.Rows[i]["q16"];	
			exSheet.Cells[pos + i,36 ].Value = dtDetail.Rows[i]["a16"];	
						
			exSheet.Cells[pos + i,37 ].Value = dtDetail.Rows[i]["q17"];	
			exSheet.Cells[pos + i,38 ].Value = dtDetail.Rows[i]["a17"];	
					
			exSheet.Cells[pos + i,39 ].Value = dtDetail.Rows[i]["q18"];	
			exSheet.Cells[pos + i,40 ].Value = dtDetail.Rows[i]["a18"];	
						
			exSheet.Cells[pos + i,41 ].Value = dtDetail.Rows[i]["q19"];	
			exSheet.Cells[pos + i,42 ].Value = dtDetail.Rows[i]["a19"];	
					
			exSheet.Cells[pos + i,43 ].Value = dtDetail.Rows[i]["q20"];	
			exSheet.Cells[pos + i,44 ].Value = dtDetail.Rows[i]["a20"];	
					
			exSheet.Cells[pos + i,45 ].Value = dtDetail.Rows[i]["q21"];	
			exSheet.Cells[pos + i,46 ].Value = dtDetail.Rows[i]["a21"];						
		
					
			exSheet.Cells[pos + i,47].Value = dtDetail.Rows[i]["q22"];	
			exSheet.Cells[pos + i,48 ].Value = dtDetail.Rows[i]["a22"];	
					
			exSheet.Cells[pos + i,49 ].Value = dtDetail.Rows[i]["q23"];	
			exSheet.Cells[pos + i,50 ].Value = dtDetail.Rows[i]["a23"];	
					
			exSheet.Cells[pos + i,51 ].Value = dtDetail.Rows[i]["q24"];	
			exSheet.Cells[pos + i,52 ].Value = dtDetail.Rows[i]["a24"];	
					
			exSheet.Cells[pos + i,53 ].Value = dtDetail.Rows[i]["q25"];	
			exSheet.Cells[pos + i,54 ].Value = dtDetail.Rows[i]["a25"];	
						
			exSheet.Cells[pos + i,55 ].Value = dtDetail.Rows[i]["q26"];	
			exSheet.Cells[pos + i,56 ].Value = dtDetail.Rows[i]["a26"];				
			
			exSheet.Cells[pos + i,57 ].Value = dtDetail.Rows[i]["q27"];	
			exSheet.Cells[pos + i,58 ].Value = dtDetail.Rows[i]["a27"];	
		
			
			exSheet.Cells[pos + i,59 ].Value = dtDetail.Rows[i]["q28"];				
			exSheet.Cells[pos + i,60 ].Value = dtDetail.Rows[i]["q28"];	
			
			exSheet.Cells[pos + i,61 ].Value = dtDetail.Rows[i]["a29"];				
			exSheet.Cells[pos + i,62 ].Value = dtDetail.Rows[i]["q29"];	
			
			exSheet.Cells[pos + i,63 ].Value = dtDetail.Rows[i]["a30"];				
			exSheet.Cells[pos + i,64 ].Value = dtDetail.Rows[i]["q30"];	
			
			exSheet.Cells[pos + i,65 ].Value = dtDetail.Rows[i]["a31"];				
			exSheet.Cells[pos + i,66 ].Value = dtDetail.Rows[i]["q31"];	
			
			exSheet.Cells[pos + i,67 ].Value = dtDetail.Rows[i]["a32"];				
			exSheet.Cells[pos + i,68 ].Value = dtDetail.Rows[i]["q32"];	
			
			exSheet.Cells[pos + i,69 ].Value = dtDetail.Rows[i]["a33"];				
			exSheet.Cells[pos + i,70 ].Value = dtDetail.Rows[i]["q33"];	
			
			exSheet.Cells[pos + i,71 ].Value = dtDetail.Rows[i]["a34"];				
			exSheet.Cells[pos + i,72 ].Value = dtDetail.Rows[i]["q34"];	
			
			exSheet.Cells[pos + i,73 ].Value = dtDetail.Rows[i]["a35"];				
			exSheet.Cells[pos + i,74 ].Value = dtDetail.Rows[i]["q35"];	
			
			exSheet.Cells[pos + i,75 ].Value = dtDetail.Rows[i]["a36"];				
			exSheet.Cells[pos + i,76 ].Value = dtDetail.Rows[i]["q36"];	
			
			exSheet.Cells[pos + i,77 ].Value = dtDetail.Rows[i]["a37"];				
			exSheet.Cells[pos + i,78 ].Value = dtDetail.Rows[i]["q37"];	
			
			exSheet.Cells[pos + i,79 ].Value = dtDetail.Rows[i]["a38"];				
			exSheet.Cells[pos + i,80 ].Value = dtDetail.Rows[i]["q38"];	
			
			exSheet.Cells[pos + i,81 ].Value = dtDetail.Rows[i]["a39"];				
			exSheet.Cells[pos + i,82 ].Value = dtDetail.Rows[i]["q39"];	
			
			exSheet.Cells[pos + i,83 ].Value = dtDetail.Rows[i]["a40"];				
			exSheet.Cells[pos + i,84 ].Value = dtDetail.Rows[i]["q40"];	
			
			exSheet.Cells[pos + i,85 ].Value = dtDetail.Rows[i]["a41"];				
			exSheet.Cells[pos + i,86 ].Value = dtDetail.Rows[i]["q41"];	
			
			exSheet.Cells[pos + i,87 ].Value = dtDetail.Rows[i]["a42"];				
			exSheet.Cells[pos + i,88 ].Value = dtDetail.Rows[i]["q42"];	
			
			exSheet.Cells[pos + i,89 ].Value = dtDetail.Rows[i]["a43"];				
			exSheet.Cells[pos + i,90 ].Value = dtDetail.Rows[i]["q43"];	
			
			exSheet.Cells[pos + i,91 ].Value = dtDetail.Rows[i]["a44"];				
			exSheet.Cells[pos + i,92 ].Value = dtDetail.Rows[i]["q44"];	
		
			exSheet.Cells[pos + i,93 ].Value = dtDetail.Rows[i]["a45"];				
			exSheet.Cells[pos + i,94 ].Value = dtDetail.Rows[i]["q45"];	
			
			exSheet.Cells[pos + i,95 ].Value = dtDetail.Rows[i]["a46"];				
			exSheet.Cells[pos + i,96 ].Value = dtDetail.Rows[i]["q46"];	
			
			exSheet.Cells[pos + i,97 ].Value = dtDetail.Rows[i]["a47"];				
			exSheet.Cells[pos + i,98 ].Value = dtDetail.Rows[i]["q47"];	
			
			exSheet.Cells[pos + i,99 ].Value = dtDetail.Rows[i]["a48"];				
			exSheet.Cells[pos + i,100].Value = dtDetail.Rows[i]["q48"];	
			
			exSheet.Cells[pos + i,101].Value = dtDetail.Rows[i]["a49"];				
			exSheet.Cells[pos + i,102].Value = dtDetail.Rows[i]["q49"];	
			
			exSheet.Cells[pos + i,103].Value = dtDetail.Rows[i]["a50"];				
			exSheet.Cells[pos + i,104].Value = dtDetail.Rows[i]["q50"];	
			
			exSheet.Cells[pos + i,105].Value = dtDetail.Rows[i]["a51"];				
			exSheet.Cells[pos + i,106].Value = dtDetail.Rows[i]["q51"];	
			
			exSheet.Cells[pos + i,107].Value = dtDetail.Rows[i]["a52"];				
			exSheet.Cells[pos + i,108].Value = dtDetail.Rows[i]["q52"];	
			
			exSheet.Cells[pos + i,109].Value = dtDetail.Rows[i]["a53"];				
			exSheet.Cells[pos + i,110].Value = dtDetail.Rows[i]["q53"];	
			
			exSheet.Cells[pos + i,111].Value = dtDetail.Rows[i]["a54"];				
			exSheet.Cells[pos + i,112].Value = dtDetail.Rows[i]["q54"];	
			
			exSheet.Cells[pos + i,113].Value = dtDetail.Rows[i]["a55"];				
			exSheet.Cells[pos + i,114].Value = dtDetail.Rows[i]["q55"];	
			
			exSheet.Cells[pos + i,115].Value = dtDetail.Rows[i]["a56"];				
			exSheet.Cells[pos + i,116].Value = dtDetail.Rows[i]["q56"];	
			
			exSheet.Cells[pos + i,117].Value = dtDetail.Rows[i]["a57"];				
			exSheet.Cells[pos + i,118].Value = dtDetail.Rows[i]["q57"];	
			
			exSheet.Cells[pos + i,119].Value = dtDetail.Rows[i]["a58"];				
			exSheet.Cells[pos + i,120].Value = dtDetail.Rows[i]["q58"];	
			
			exSheet.Cells[pos + i,121].Value = dtDetail.Rows[i]["a59"];				
			exSheet.Cells[pos + i,122].Value = dtDetail.Rows[i]["q59"];	
			
			exSheet.Cells[pos + i,123].Value = dtDetail.Rows[i]["a60"];				
			exSheet.Cells[pos + i,124].Value = dtDetail.Rows[i]["q60"];	
			
        }
		
		exSheet.Cells[4, 3 ].Value = "=sum(c7:c"+(pos+i-1)+")";
		exSheet.Cells[4, 4 ].Value = "=sum(d7:d"+(pos+i-1)+")";
		exSheet.Cells[4, 5 ].Value = "=sum(e7:e"+(pos+i-1)+")";
		exSheet.Cells[4, 6 ].Value = "=sum(f7:f"+(pos+i-1)+")";
		exSheet.Cells[4, 7 ].Value = "=sum(g7:g"+(pos+i-1)+")";
		exSheet.Cells[4, 8 ].Value = "=sum(h7:h"+(pos+i-1)+")";
		exSheet.Cells[4, 9 ].Value = "=sum(i7:i"+(pos+i-1)+")";
		exSheet.Cells[4, 10 ].Value = "=sum(j7:j"+(pos+i-1)+")";
		exSheet.Cells[4, 11 ].Value = "=sum(k7:k"+(pos+i-1)+")";
		exSheet.Cells[4, 12].Value = "=sum(l7:l"+(pos+i-1)+")";
		exSheet.Cells[4, 13].Value = "=sum(m7:m"+(pos+i-1)+")";
		exSheet.Cells[4, 14].Value = "=sum(n7:n"+(pos+i-1)+")";
		exSheet.Cells[4, 15].Value = "=sum(o7:o"+(pos+i-1)+")";
		exSheet.Cells[4, 16].Value = "=sum(p7:p"+(pos+i-1)+")";
		exSheet.Cells[4, 17].Value = "=sum(q7:q"+(pos+i-1)+")";
		exSheet.Cells[4, 18].Value = "=sum(r7:r"+(pos+i-1)+")";
		exSheet.Cells[4, 19].Value = "=sum(s7:s"+(pos+i-1)+")";
		
		exSheet.Cells[4, 20].Value = "=sum(t7:t"+(pos+i-1)+")";
		exSheet.Cells[4, 21].Value = "=sum(u7:u"+(pos+i-1)+")";
		exSheet.Cells[4, 22].Value = "=sum(v7:v"+(pos+i-1)+")";
		exSheet.Cells[4, 23].Value = "=sum(w7:w"+(pos+i-1)+")";
		exSheet.Cells[4, 24].Value = "=sum(x7:x"+(pos+i-1)+")";
		exSheet.Cells[4, 25].Value = "=sum(y7:y"+(pos+i-1)+")";
		exSheet.Cells[4, 26].Value = "=sum(z7:z"+(pos+i-1)+")";
		exSheet.Cells[4, 27].Value = "=sum(aa7:aa"+(pos+i-1)+")";
		exSheet.Cells[4, 28].Value = "=sum(ab7:ab"+(pos+i-1)+")";
		exSheet.Cells[4, 29].Value = "=sum(ac7:ac"+(pos+i-1)+")";
		exSheet.Cells[4, 30].Value = "=sum(ad7:ad"+(pos+i-1)+")";
		exSheet.Cells[4, 31].Value = "=sum(ae7:ae"+(pos+i-1)+")";
		exSheet.Cells[4, 32].Value = "=sum(af7:af"+(pos+i-1)+")";
		exSheet.Cells[4, 33].Value = "=sum(ag7:ag"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(ai7:ai"+(pos+i-1)+")";
		
		exSheet.Cells[4, 34].Value = "=sum(aj7:aj"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(ak7:ak"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(al7:al"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(am7:an"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(an7:an"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(ao7:ao"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(ap7:ap"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(aq7:aq"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(ar7:ar"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(as7:as"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(at7:at"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(au7:au"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(av7:av"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(aw7:aw"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(ax7:ax"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(ay7:ay"+(pos+i-1)+")";
		exSheet.Cells[4, 34].Value = "=sum(az7:az"+(pos+i-1)+")";
		
			
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

   
}