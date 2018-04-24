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

public partial class rpt_fppr00310_DUR01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		//ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_fppr00310_DUR01.xls";
        string TempFile = "../../../system/temp/rpt_fppr00310_DUR01_" + Session["User_ID"].ToString() + ".xls";
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
               	
        DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fppr00310_DUR01_1" , para);
		DataTable dtMaster = ESysLib.TableReadOpenCursor("lg_rpt_fppr00310_DUR01_2" , para);
						
		// INSERT ROWS
		for (int l_addrow = 0; l_addrow < dtDetail.Rows.Count-1; l_addrow++)
        {
            exSheet.Range["A6"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		if ( dtMaster.Rows.Count>0 )
		{
			exSheet.Cells[ 1, 9 ].Value = dtMaster.Rows[0]["prod_date"];
		}	
		// SET DATA
		int pos = 5 ;
		int i   = 0 ;
		int t   = 0 ;
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {		
			t = pos+i;
			
            exSheet.Cells[ t, 1  ].Value = dtDetail.Rows[i]["week_type"];
			exSheet.Cells[ t, 2  ].Value = dtDetail.Rows[i]["car_date"];
			exSheet.Cells[ t, 3  ].Value = dtDetail.Rows[i]["car_day"];
			exSheet.Cells[ t, 4  ].Value = dtDetail.Rows[i]["line_id"];
			exSheet.Cells[ t, 5  ].Value = dtDetail.Rows[i]["work_shift"];
			exSheet.Cells[ t, 6  ].Value = dtDetail.Rows[i]["item_code"];
			exSheet.Cells[ t, 7  ].Value = dtDetail.Rows[i]["item_name"];
			exSheet.Cells[ t, 8  ].Value = dtDetail.Rows[i]["cycle_time"];
			exSheet.Cells[ t, 9  ].Value = dtDetail.Rows[i]["full_cavity"];			
			exSheet.Cells[ t, 10 ].Value = dtDetail.Rows[i]["act_cavity"];
			
			exSheet.Cells[ t, 11 ].Value = "=+IF(J"+t+">0,H"+t+"*I"+t+"/J"+t+",H"+t+")";
						
			exSheet.Cells[ t, 12 ].Value = dtDetail.Rows[i]["full_name"]; 
			exSheet.Cells[ t, 13 ].Value = dtDetail.Rows[i]["emp_id"];
			
			exSheet.Cells[ t, 14 ].Value = "=+INT(3600/K"+t+")";
			exSheet.Cells[ t, 15 ].Value = "=INT(N"+t+"*S"+t+")";
			
			exSheet.Cells[ t, 16 ].Value = dtDetail.Rows[i]["ok_qty"];
			exSheet.Cells[ t, 17 ].Value = dtDetail.Rows[i]["ng_qty"];			
			exSheet.Cells[ t, 18 ].Value = "=(Q"+t+"+P"+t+")";
							
			exSheet.Cells[ t, 19 ].Value = dtDetail.Rows[i]["work_time"];
			exSheet.Cells[ t, 20 ].Value = "=(S"+t+"-U"+t+")";	
			exSheet.Cells[ t, 21 ].Value = dtDetail.Rows[i]["none_work_time"];	
			exSheet.Cells[ t, 22 ].Value = "=(H"+t+"*P"+t+")/3600";
			exSheet.Cells[ t, 23 ].Value = "=(T"+t+"/S"+t+")";			
			exSheet.Cells[ t, 24 ].Value = "=(V"+t+"/T"+t+")";
			
			exSheet.Cells[ t, 25 ].Value = "=(P"+t+"/R"+t+")";
			exSheet.Cells[ t, 26 ].Value = "=(Y"+t+"*X"+t+"*W"+t+")";
			exSheet.Cells[ t, 27 ].Value = "=(P"+t+"/O"+t+")";
			exSheet.Cells[ t, 28 ].Value = "=INT(T"+t+"*N"+t+")";
			exSheet.Cells[ t, 29 ].Value = "=(R"+t+"/AB"+t+")";
			
			exSheet.Cells[ t, 30 ].Value = dtDetail.Rows[i]["att01"];	
			exSheet.Cells[ t, 31 ].Value = dtDetail.Rows[i]["att02"];	
			//-------------					 
        }
						
		t = t+1 ;
		
		exSheet.Cells[ t, 15 ].Value = "=sum(O5:O"+(t-1)+")";
		exSheet.Cells[ t, 16 ].Value = "=sum(P5:P"+(t-1)+")";	
		exSheet.Cells[ t, 17 ].Value = "=sum(Q5:Q"+(t-1)+")";	
		exSheet.Cells[ t, 18 ].Value = "=sum(R5:R"+(t-1)+")";	
		exSheet.Cells[ t, 19 ].Value = "=sum(S5:S"+(t-1)+")";	
		exSheet.Cells[ t, 20 ].Value = "=sum(T5:T"+(t-1)+")";			
		exSheet.Cells[ t, 21 ].Value = "=sum(U5:U"+(t-1)+")";	
		exSheet.Cells[ t, 22 ].Value = "=sum(V5:V"+(t-1)+")";
		
		exSheet.Cells[ t, 23 ].Value = "=(T"+t+"/S"+t+")";
		exSheet.Cells[ t, 24 ].Value = "=(V"+t+"/T"+t+")";	
		exSheet.Cells[ t, 25 ].Value = "=(P"+t+"/R"+t+")";	
		exSheet.Cells[ t, 26 ].Value = "=(Y"+t+"*X"+t+"*W"+t+")";	
		exSheet.Cells[ t, 27 ].Value = "=(P"+t+"/O"+t+")";	
		exSheet.Cells[ t, 28 ].Value = "=sum(AB5:AB"+(t-1)+")";
		exSheet.Cells[ t, 29 ].Value = "=(R"+t+"/AB"+t+")";
		
		exSheet.Cells[ 2, 12 ].Value = "=(R"+t+"/AB"+t+")";
		
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