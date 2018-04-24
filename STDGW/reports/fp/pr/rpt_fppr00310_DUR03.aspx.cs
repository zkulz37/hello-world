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

public partial class rpt_fppr00310_DUR03 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		//ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_fppr00310_DUR03.xls";
        string TempFile = "../../../system/temp/rpt_fppr00310_DUR03_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;
   
        //bind data to excel file
        string p_from_date = Request.QueryString["p_from_date"];
		string p_to_date   = Request.QueryString["p_to_date"];
		string p_wh_pk     = Request.QueryString["p_wh_pk"];		 
		
		string para = "'" + p_wh_pk + "','" + p_from_date + "','" + p_to_date + "'";
               	
        DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fppr00310_DUR03_1" , para);
		DataTable dtMaster = ESysLib.TableReadOpenCursor("lg_rpt_fppr00310_DUR03_2" , para);
									
		if ( dtMaster.Rows.Count>0 )
		{
			exSheet.Cells[ 4, 6 ].Value = dtMaster.Rows[0]["prod_date"];
		}

		// SET DATA
		int pos = 8 ;
		int i   = 0 ;
		int t   = 8 ;
		int last_t = 8;
		
		Color color1 = ColorTranslator.FromHtml("0xFFFFCC");
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {							
			exSheet.Range[ t+1, 1].Rows.EntireRow.Insert();
			
            exSheet.Cells[ t, 1  ].Value = dtDetail.Rows[i]["grp_nm"];
			exSheet.Cells[ t, 2  ].Value = dtDetail.Rows[i]["work_shift"];
			exSheet.Cells[ t, 3  ].Value = dtDetail.Rows[i]["mc_qty"];
			exSheet.Cells[ t, 4  ].Value = dtDetail.Rows[i]["cycle_time"];
			exSheet.Cells[ t, 5  ].Value = "=(F"+t+"*3600)/D"+t;
			exSheet.Cells[ t, 6  ].Value = dtDetail.Rows[i]["plan_time"];
			exSheet.Cells[ t, 7  ].Value = dtDetail.Rows[i]["ok_qty"];						
			exSheet.Cells[ t, 8  ].Value = dtDetail.Rows[i]["ng_qty"]; 			
			exSheet.Cells[ t, 9  ].Value = "=(F"+t+"-J"+t+")";					
			exSheet.Cells[ t, 10 ].Value = dtDetail.Rows[i]["none_time"];
			
			exSheet.Cells[ t, 11 ].Value = "=(D"+t+"*G"+t+")/3600";
			
			exSheet.Cells[ t, 12 ].Value = "=IFERROR(I"+t+"/F"+t+",0)";			
			exSheet.Cells[ t, 13 ].Value = "=IFERROR(K"+t+"/I"+t+",0)";		
			exSheet.Cells[ t, 14 ].Value = "=IFERROR(G"+t+"/(H"+t+"+G"+t+"),0)";
			
			exSheet.Cells[ t, 15 ].Value = "=IFERROR(N"+t+"*M"+t+"*L"+t+",0)";
			
			exSheet.Cells[ t, 16 ].Value = "=IFERROR(G"+t+"/E"+t+",0)";
			
			t++;
			//-------------

			if ( ((i+1 < dtDetail.Rows.Count) && (dtDetail.Rows[i]["grp_nm"].ToString() != dtDetail.Rows[i+1]["grp_nm"].ToString())) || ( i+1 == dtDetail.Rows.Count ) )
			{							
				exSheet.Range[ t+1, 1].Rows.EntireRow.Insert();
				
				exSheet.Cells[ t, 1, t, 17].Interior.Color = color1;//Color.Blue;
				
				exSheet.Cells[ t, 1  ].Value = dtDetail.Rows[i]["grp_nm"];
				exSheet.Cells[ t, 2  ].Value = "Total";
				exSheet.Cells[ t, 3  ].Value = "=MAX(C"+last_t+":C"+(t-1)+")";
				exSheet.Cells[ t, 4  ].Value = "=AVERAGE(D"+last_t+":D"+(t-1)+")";
				exSheet.Cells[ t, 5  ].Value = "=SUM(E"+last_t+":E"+(t-1)+")";
				exSheet.Cells[ t, 6  ].Value = "=SUM(F"+last_t+":F"+(t-1)+")";
				exSheet.Cells[ t, 7  ].Value = "=SUM(G"+last_t+":G"+(t-1)+")";				
				exSheet.Cells[ t, 8  ].Value = "=SUM(H"+last_t+":H"+(t-1)+")";		
				exSheet.Cells[ t, 9  ].Value = "=SUM(I"+last_t+":I"+(t-1)+")";					
				exSheet.Cells[ t, 10 ].Value = "=SUM(J"+last_t+":J"+(t-1)+")";		
				
				exSheet.Cells[ t, 11 ].Value = "=SUM(K"+last_t+":K"+(t-1)+")";	
				
				exSheet.Cells[ t, 12 ].Value = "=IFERROR(I"+t+"/F"+t+",0)";			
				exSheet.Cells[ t, 13 ].Value = "=IFERROR(K"+t+"/I"+t+",0)";		
				exSheet.Cells[ t, 14 ].Value = "=IFERROR(G"+t+"/(H"+t+"+G"+t+"),0)";
				
				exSheet.Cells[ t, 15 ].Value = "=IFERROR(N"+t+"*M"+t+"*L"+t+",0)";
				
				exSheet.Cells[ t, 16 ].Value = "=IFERROR(G"+t+"/E"+t+",0)";
								
				last_t = t+1;			
				
				t++;
			}
        }
						
		/*t = t+1 ;
		
		exSheet.Cells[ t, 12 ].Value = "=sum(L5:L"+(t-1)+")";
		exSheet.Cells[ t, 13 ].Value = "=sum(M5:M"+(t-1)+")";
		exSheet.Cells[ t, 14 ].Value = "=sum(N5:N"+(t-1)+")";	
		exSheet.Cells[ t, 15 ].Value = "=sum(O5:O"+(t-1)+")";	
		exSheet.Cells[ t, 16 ].Value = "=sum(P5:P"+(t-1)+")";	
		exSheet.Cells[ t, 17 ].Value = "=sum(Q5:Q"+(t-1)+")";			
		exSheet.Cells[ t, 18 ].Value = "=sum(R5:R"+(t-1)+")";	
		exSheet.Cells[ t, 19 ].Value = "=sum(S5:S"+(t-1)+")";	
		exSheet.Cells[ t, 20 ].Value = "=(Q"+t+"/P"+t+")";
		exSheet.Cells[ t, 21 ].Value = "=(S"+t+"/Q"+t+")";
		exSheet.Cells[ t, 22 ].Value = "=(M"+t+"/O"+t+")";
		
		exSheet.Cells[ t, 20 ].Value = "=sum(T5:T"+(t-1)+")";			
		exSheet.Cells[ t, 21 ].Value = "=sum(U5:U"+(t-1)+")";	
		exSheet.Cells[ t, 22 ].Value = "=sum(V5:V"+(t-1)+")";
		exSheet.Cells[ t, 23 ].Value = "=(V"+t+"*U"+t+"*T"+t+")";
		exSheet.Cells[ t, 24 ].Value = "=sum(X5:X"+(t-1)+")";
		
		exSheet.Cells[ t, 25 ].Value = "=(O"+t+"/L"+t+")";
		exSheet.Cells[ t, 26 ].Value = "=(M"+t+"/L"+t+")";	
		
		exSheet.Cells[ 2, 9 ].Value = "=(O"+t+"/L"+t+")";*/
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