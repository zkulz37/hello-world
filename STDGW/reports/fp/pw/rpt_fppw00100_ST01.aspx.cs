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

public partial class rpt_fppw00100_ST01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());        

        string TemplateFile = "rpt_fppw00100_ST01.xls";
        string TempFile = "../../../system/temp/rpt_fppw00100_ST01_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file

		string p_pb_line_group_pk = Request.QueryString["p_pb_line_group_pk"];
		string p_pb_line_pk = Request.QueryString["p_pb_line_pk"];
		string p_itemgrp_pk = Request.QueryString["p_itemgrp_pk"];
		string p_item = Request.QueryString["p_item"];
		string p_date = Request.QueryString["p_date"];
		 
        string para_header = "'" + p_date + "'";
		
		string para_dtl = "'" + p_pb_line_group_pk + "','" + p_pb_line_pk + "','" + p_itemgrp_pk + "','" + p_item + "','" + p_date + "'";

		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_bisc00020_ST01_1", "'" + Session["User_ID"].ToString() + "'");	
	
		DataTable dtHeader = ESysLib.TableReadOpenCursor("lg_rpt_fppw00100_st01_header", para_header);	
		
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fppw00100_st01", para_dtl);	
        ////end-set-----DataBind--in---Master---
		if (!string.IsNullOrEmpty(dtInfo.Rows[0]["pic"].ToString()))
        {
            exSheet.Cells[1, 1].Select();
            byte[] MyData = new byte[0];
            MyData = (byte[])dtInfo.Rows[0]["pic"];
            MemoryStream stream = new MemoryStream(MyData);

            Bitmap b = new Bitmap(stream);
            exSheet.Shapes.AddPicture(ResizeImage(b, 100, 55));
        }
		exSheet.Cells["C1"].Value = dtInfo.Rows[0]["partner_name"].ToString();

        exSheet.Cells["C2"].Value = dtInfo.Rows[0]["addr1"].ToString();

        exSheet.Cells["C3"].Value = "Tax code: " + dtInfo.Rows[0]["tax_code"].ToString();
		
		if(dtHeader.Rows.Count >0)
		{
			exSheet.Cells[5,5].Value = dtHeader.Rows[0]["from_date15"].ToString(); 
			exSheet.Cells[5,7].Value = dtHeader.Rows[0]["from_date14"].ToString(); 
			exSheet.Cells[5,9].Value = dtHeader.Rows[0]["from_date13"].ToString(); 
			exSheet.Cells[5,11].Value = dtHeader.Rows[0]["from_date12"].ToString(); 
			exSheet.Cells[5,13].Value = dtHeader.Rows[0]["from_date11"].ToString(); 
			exSheet.Cells[5,15].Value = dtHeader.Rows[0]["from_date10"].ToString(); 
			exSheet.Cells[5,17].Value = dtHeader.Rows[0]["from_date09"].ToString(); 
			exSheet.Cells[5,19].Value = dtHeader.Rows[0]["from_date08"].ToString(); 
			exSheet.Cells[5,21].Value = dtHeader.Rows[0]["from_date07"].ToString(); 
			exSheet.Cells[5,23].Value = dtHeader.Rows[0]["from_date06"].ToString(); 
			exSheet.Cells[5,25].Value = dtHeader.Rows[0]["from_date05"].ToString(); 
			exSheet.Cells[5,27].Value = dtHeader.Rows[0]["from_date04"].ToString(); 
			exSheet.Cells[5,29].Value = dtHeader.Rows[0]["from_date03"].ToString(); 
			exSheet.Cells[5,31].Value = dtHeader.Rows[0]["from_date02"].ToString(); 
			exSheet.Cells[5,33].Value = dtHeader.Rows[0]["from_date01"].ToString(); 
			exSheet.Cells[5,35].Value = dtHeader.Rows[0]["from_date00"].ToString(); 
		}
		
        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A7"].Rows.EntireRow.Insert();//insert row new of sheet
        }
        //set data to detail.
        // loop detail not percent
		int l_pos = 6;
		int i = 0 ;
		double wi_15=0,wi_14=0,wi_13=0,wi_12=0,wi_11=0,wi_10=0,wi_09=0,wi_08=0,wi_07=0,wi_06=0,wi_05=0,wi_04=0,wi_03=0,wi_02=0,wi_01=0,wi_00=0;
		double re_15=0,re_14=0,re_13=0,re_12=0,re_11=0,re_10=0,re_09=0,re_08=0,re_07=0,re_06=0,re_05=0,re_04=0,re_03=0,re_02=0,re_01=0,re_00=0;
		
        for (i = 0; i < dtDetail.Rows.Count; i++)
        {
            exSheet.Cells[l_pos+i,1].Value =i+1;
			exSheet.Cells[l_pos+i,2].Value = dtDetail.Rows[i]["item_code"].ToString(); 
			exSheet.Cells[l_pos+i,3].Value = dtDetail.Rows[i]["item_name"].ToString(); 
			exSheet.Cells[l_pos+i,4].Value = dtDetail.Rows[i]["uom"].ToString();
			if(dtDetail.Rows[i]["wi_15"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,5].Value = double.Parse(dtDetail.Rows[i]["wi_15"].ToString());
				wi_15=wi_15+double.Parse(dtDetail.Rows[i]["wi_15"].ToString());
			}
			if(dtDetail.Rows[i]["re_15"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,6].Value = double.Parse(dtDetail.Rows[i]["re_15"].ToString());
				re_15=re_15+double.Parse(dtDetail.Rows[i]["re_15"].ToString());
			}
			if(dtDetail.Rows[i]["wi_14"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,7].Value = double.Parse(dtDetail.Rows[i]["wi_14"].ToString());
				wi_14=wi_14+double.Parse(dtDetail.Rows[i]["wi_14"].ToString());
			}
			if(dtDetail.Rows[i]["re_14"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,8].Value = double.Parse(dtDetail.Rows[i]["re_14"].ToString());
				re_14=re_14+double.Parse(dtDetail.Rows[i]["re_14"].ToString());
			}
			if(dtDetail.Rows[i]["wi_13"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,9].Value = double.Parse(dtDetail.Rows[i]["wi_13"].ToString());
				wi_13=wi_13+double.Parse(dtDetail.Rows[i]["wi_13"].ToString());
			}
			if(dtDetail.Rows[i]["re_13"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,10].Value = double.Parse(dtDetail.Rows[i]["re_13"].ToString());
				re_13=re_13+double.Parse(dtDetail.Rows[i]["re_13"].ToString());
			}
			if(dtDetail.Rows[i]["wi_12"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,11].Value = double.Parse(dtDetail.Rows[i]["wi_12"].ToString());
				wi_12=wi_12+double.Parse(dtDetail.Rows[i]["wi_12"].ToString());
			}
			if(dtDetail.Rows[i]["re_12"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,12].Value = double.Parse(dtDetail.Rows[i]["re_12"].ToString());
				re_12=re_12+double.Parse(dtDetail.Rows[i]["re_12"].ToString());
			}
			if(dtDetail.Rows[i]["wi_11"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,13].Value = double.Parse(dtDetail.Rows[i]["wi_11"].ToString());
				wi_11=wi_11+double.Parse(dtDetail.Rows[i]["wi_11"].ToString());
			}
			if(dtDetail.Rows[i]["re_11"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,14].Value = double.Parse(dtDetail.Rows[i]["re_11"].ToString());
				re_11=re_11+double.Parse(dtDetail.Rows[i]["re_11"].ToString());
			}
			if(dtDetail.Rows[i]["wi_10"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,15].Value = double.Parse(dtDetail.Rows[i]["wi_10"].ToString());
				wi_10=wi_10+double.Parse(dtDetail.Rows[i]["wi_10"].ToString());
			}
			if(dtDetail.Rows[i]["re_10"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,16].Value = double.Parse(dtDetail.Rows[i]["re_10"].ToString());
				re_10=re_10+double.Parse(dtDetail.Rows[i]["re_10"].ToString());
			}	
			if(dtDetail.Rows[i]["wi_09"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,17].Value = double.Parse(dtDetail.Rows[i]["wi_09"].ToString());
				wi_09=wi_09+double.Parse(dtDetail.Rows[i]["wi_09"].ToString());
			}
			if(dtDetail.Rows[i]["re_09"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,18].Value = double.Parse(dtDetail.Rows[i]["re_09"].ToString());
				re_09=re_09+double.Parse(dtDetail.Rows[i]["re_09"].ToString());
			}	
			if(dtDetail.Rows[i]["wi_08"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,19].Value = double.Parse(dtDetail.Rows[i]["wi_08"].ToString());
				wi_08=wi_08+double.Parse(dtDetail.Rows[i]["wi_08"].ToString());
			}
			if(dtDetail.Rows[i]["re_08"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,20].Value = double.Parse(dtDetail.Rows[i]["re_08"].ToString());
				re_08=re_08+double.Parse(dtDetail.Rows[i]["re_08"].ToString());
			}	
			if(dtDetail.Rows[i]["wi_07"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,21].Value = double.Parse(dtDetail.Rows[i]["wi_07"].ToString());
				wi_07=wi_07+double.Parse(dtDetail.Rows[i]["wi_07"].ToString());
			}
			if(dtDetail.Rows[i]["re_07"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,22].Value = double.Parse(dtDetail.Rows[i]["re_07"].ToString());
				re_07=re_07+double.Parse(dtDetail.Rows[i]["re_07"].ToString());
			}	
			if(dtDetail.Rows[i]["wi_06"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,23].Value = double.Parse(dtDetail.Rows[i]["wi_06"].ToString());
				wi_06=wi_06+double.Parse(dtDetail.Rows[i]["wi_06"].ToString());
			}
			if(dtDetail.Rows[i]["re_06"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,24].Value = double.Parse(dtDetail.Rows[i]["re_06"].ToString());
				re_06=re_06+double.Parse(dtDetail.Rows[i]["re_06"].ToString());
			}	
			if(dtDetail.Rows[i]["wi_05"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,25].Value = double.Parse(dtDetail.Rows[i]["wi_05"].ToString());
				wi_05=wi_05+double.Parse(dtDetail.Rows[i]["wi_05"].ToString());
			}
			if(dtDetail.Rows[i]["re_05"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,26].Value = double.Parse(dtDetail.Rows[i]["re_05"].ToString());
				re_05=re_05+double.Parse(dtDetail.Rows[i]["re_05"].ToString());
			}	
			if(dtDetail.Rows[i]["wi_04"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,27].Value = double.Parse(dtDetail.Rows[i]["wi_04"].ToString());
				wi_04=wi_04+double.Parse(dtDetail.Rows[i]["wi_04"].ToString());
			}
			if(dtDetail.Rows[i]["re_04"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,28].Value = double.Parse(dtDetail.Rows[i]["re_04"].ToString());
				re_04=re_04+double.Parse(dtDetail.Rows[i]["re_04"].ToString());
			}	
			if(dtDetail.Rows[i]["wi_03"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,29].Value = double.Parse(dtDetail.Rows[i]["wi_03"].ToString());
				wi_03=wi_03+double.Parse(dtDetail.Rows[i]["wi_03"].ToString());
			}
			if(dtDetail.Rows[i]["re_03"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,30].Value = double.Parse(dtDetail.Rows[i]["re_03"].ToString());
				re_03=re_03+double.Parse(dtDetail.Rows[i]["re_03"].ToString());
			}	
			if(dtDetail.Rows[i]["wi_02"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,31].Value = double.Parse(dtDetail.Rows[i]["wi_02"].ToString());
				wi_02=wi_02+double.Parse(dtDetail.Rows[i]["wi_02"].ToString());
			}
			if(dtDetail.Rows[i]["re_02"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,32].Value = double.Parse(dtDetail.Rows[i]["re_02"].ToString());
				re_02=re_02+double.Parse(dtDetail.Rows[i]["re_02"].ToString());
			}	
			if(dtDetail.Rows[i]["wi_01"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,33].Value = double.Parse(dtDetail.Rows[i]["wi_01"].ToString());
				wi_01=wi_01+double.Parse(dtDetail.Rows[i]["wi_01"].ToString());
			}
			if(dtDetail.Rows[i]["re_01"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,34].Value = double.Parse(dtDetail.Rows[i]["re_01"].ToString());
				re_01=re_01+double.Parse(dtDetail.Rows[i]["re_01"].ToString());
			}	
			if(dtDetail.Rows[i]["wi_00"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,35].Value = double.Parse(dtDetail.Rows[i]["wi_00"].ToString());
				wi_00=wi_00+double.Parse(dtDetail.Rows[i]["wi_00"].ToString());
			}
			if(dtDetail.Rows[i]["re_00"].ToString() !="")
			{
				exSheet.Cells[l_pos+i,36].Value = double.Parse(dtDetail.Rows[i]["re_00"].ToString());
				re_00=re_00+double.Parse(dtDetail.Rows[i]["re_00"].ToString());
			}	
        }
        
		
		exSheet.Cells[dtDetail.Rows.Count + 6, 5].Value = "=SUM(E5:E" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 6].Value = "=SUM(F5:F" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 7].Value = "=SUM(G5:G" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 8].Value = "=SUM(H5:H" + (dtDetail.Rows.Count + 5) + ")";
		exSheet.Cells[dtDetail.Rows.Count + 6, 9].Value = "=SUM(I5:I" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 10].Value = "=SUM(J5:J" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 11].Value = "=SUM(K5:K" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 12].Value = "=SUM(L5:L" + (dtDetail.Rows.Count + 5) + ")";
		exSheet.Cells[dtDetail.Rows.Count + 6, 13].Value = "=SUM(M5:M" + (dtDetail.Rows.Count + 5) + ")";
		exSheet.Cells[dtDetail.Rows.Count + 6, 14].Value = "=SUM(N5:N" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 15].Value = "=SUM(O5:O" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 16].Value = "=SUM(P5:P" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 17].Value = "=SUM(Q5:Q" + (dtDetail.Rows.Count + 5) + ")";
		exSheet.Cells[dtDetail.Rows.Count + 6, 18].Value = "=SUM(R5:R" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 19].Value = "=SUM(S5:S" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 20].Value = "=SUM(T5:T" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 21].Value = "=SUM(U5:U" + (dtDetail.Rows.Count + 5) + ")";	
		exSheet.Cells[dtDetail.Rows.Count + 6, 22].Value = "=SUM(V5:V" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 23].Value = "=SUM(W5:W" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 24].Value = "=SUM(X5:X" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 25].Value = "=SUM(Y5:Y" + (dtDetail.Rows.Count + 5) + ")";
		exSheet.Cells[dtDetail.Rows.Count + 6, 26].Value = "=SUM(Z5:Z" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 27].Value = "=SUM(AA5:AA" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 28].Value = "=SUM(AB5:AB" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 29].Value = "=SUM(AC5:AC" + (dtDetail.Rows.Count + 5) + ")";
		exSheet.Cells[dtDetail.Rows.Count + 6, 30].Value = "=SUM(AD5:AD" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 31].Value = "=SUM(AE5:AE" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 32].Value = "=SUM(AF5:AF" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 33].Value = "=SUM(AG5:AG" + (dtDetail.Rows.Count + 5) + ")";
		exSheet.Cells[dtDetail.Rows.Count + 6, 34].Value = "=SUM(AH5:AH" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 35].Value = "=SUM(AI5:AI" + (dtDetail.Rows.Count + 5) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 6, 36].Value = "=SUM(AJ5:AJ" + (dtDetail.Rows.Count + 5) + ")";
        
        // end loop detail not percent

        // end loop detail percent
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