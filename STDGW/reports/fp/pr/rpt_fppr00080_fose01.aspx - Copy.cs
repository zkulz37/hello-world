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

public partial class rpt_fppr00080_fose01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		//ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_fppr00080_fose01.xls";
        string TempFile = "../../../system/temp/rpt_fppr00080_fose01_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		 
        string     p_month = Request["p_month"];
		string     p_wh = Request["p_wh"];
         
        string para = "'" + p_wh + "','" + p_month + "'";		
		DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080", para);		  
		
		//string p_tlg_in_warehouse_pk =Request["p_tlg_in_warehouse_pk"];
        //string p_month1 = Request["p_month1"];
		
		//string para1 = "'" + p_tlg_in_warehouse_pk + "','" + p_month1 + "'";		
		DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080_week", para);
        // MASTER  
	
			exSheet.Cells["BO5"].Value = dt.Rows[0]["mor_price_kor"];
			exSheet.Cells["BP5"].Value = dt.Rows[0]["mor_price"];
			exSheet.Cells["BS5"].Value = dt.Rows[0]["lun_price_kor"];
			exSheet.Cells["BT5"].Value = dt.Rows[0]["lun_price"];
			exSheet.Cells["BW5"].Value = dt.Rows[0]["din_price_kor"];
			exSheet.Cells["BX5"].Value = dt.Rows[0]["din_price"];
			exSheet.Cells["CA5"].Value = dt.Rows[0]["nig_price_kor"];
			exSheet.Cells["CB5"].Value = dt.Rows[0]["nig_price"];
       
		//if( dt.Rows.Count >0)
		//{
			// exSheet.Cells["h6"].Value =dt.Rows[0]["slip_no"];
			// //exSheet.Cells["h7"].Value = "No/dr ";//+dt.Rows[0]["req_date"];
			// //exSheet.Cells["h8"].Value = "Co/cr";//;+dt.Rows[0]["dept_name"];
			// exSheet.Cells["e8"].Value =dt.Rows[0]["dd"];
			// exSheet.Cells["f8"].Value =dt.Rows[0]["mm"];
			// exSheet.Cells["h8"].Value =dt.Rows[0]["yy"];
			// exSheet.Cells["e9"].Value =dt.Rows[0]["partner_name"];
			// exSheet.Cells["e10"].Value =dt.Rows[0]["ref_no"];
			// exSheet.Cells["d11"].Value =dt.Rows[0]["in_date"];
			// exSheet.Cells["e12"].Value =dt.Rows[0]["wh_nm"];
			
			
		//}
		
		// INSERT ROWS
		 
		for (int l_addrow = 0; l_addrow < dt.Rows.Count-1; l_addrow++)
		{
         exSheet.Range["A7"].Rows.EntireRow.Insert();//insert row new of sheet
		}
						
		// SET DATA
		int pos = 6;
		int i   = 0  ;		  			
	
		for (i = 0; i < dt.Rows.Count; i++)
        {	
			exSheet.Cells[pos + i, 1 ].Value = dt.Rows[i]["prod_date"];
			exSheet.Cells[pos + i, 2 ].Value = dt.Rows[i]["hq_sang"]; 
			exSheet.Cells[pos + i, 3 ].Value = dt.Rows[i]["lon_sang"];	
			exSheet.Cells[pos + i, 4].Value = dt.Rows[i]["bo_sang"];			
			exSheet.Cells[pos + i, 5].Value = dt.Rows[i]["ga_sang"]; 
			exSheet.Cells[pos + i, 6].Value = dt.Rows[i]["ca_sang"]; 
			exSheet.Cells[pos + i, 7].Value = dt.Rows[i]["bp_sang"]; 
			exSheet.Cells[pos + i, 8].Value = dt.Rows[i]["cr_sang"]; 
			exSheet.Cells[pos + i, 9].Value = dt.Rows[i]["chao_sang"]; 
			exSheet.Cells[pos + i, 10].Value = dt.Rows[i]["banh_sang"]; 
			exSheet.Cells[pos + i, 11].Value = dt.Rows[i]["trung_sang"]; 
			exSheet.Cells[pos + i,12].Value = dt.Rows[i]["tiec_sang"]; 
			exSheet.Cells[pos + i,13].Value = dt.Rows[i]["total_sang"]; 
			
			exSheet.Cells[pos + i,14].Value = dt.Rows[i]["hq_trua"]; 
			exSheet.Cells[pos + i,15].Value = dt.Rows[i]["lon_trua"]; 
			exSheet.Cells[pos + i,16].Value = dt.Rows[i]["bo_trua"]; 
			exSheet.Cells[pos + i,17].Value = dt.Rows[i]["ga_trua"]; 
			exSheet.Cells[pos + i,18].Value = dt.Rows[i]["ca_trua"]; 
			exSheet.Cells[pos + i,19].Value = dt.Rows[i]["bp_trua"]; 
			exSheet.Cells[pos + i,20].Value = dt.Rows[i]["cr_trua"]; 
			exSheet.Cells[pos + i,21].Value = dt.Rows[i]["chao_trua"]; 
			exSheet.Cells[pos + i,22].Value = dt.Rows[i]["banh_trua"]; 
			exSheet.Cells[pos + i,23].Value = dt.Rows[i]["trung_trua"]; 
			exSheet.Cells[pos + i,24].Value = dt.Rows[i]["tiec_trua"]; 
			exSheet.Cells[pos + i,25].Value = dt.Rows[i]["total_trua"];
			
			exSheet.Cells[pos + i,26].Value = dt.Rows[i]["hq_chieu"]; 
			exSheet.Cells[pos + i,27].Value = dt.Rows[i]["lon_chieu"]; 
			exSheet.Cells[pos + i,28].Value = dt.Rows[i]["bo_chieu"]; 
			exSheet.Cells[pos + i,29].Value = dt.Rows[i]["ga_chieu"]; 
			exSheet.Cells[pos + i,30].Value = dt.Rows[i]["ca_chieu"]; 
			exSheet.Cells[pos + i,31].Value = dt.Rows[i]["bp_chieu"]; 
			exSheet.Cells[pos + i,32].Value = dt.Rows[i]["cr_chieu"]; 
			exSheet.Cells[pos + i,33].Value = dt.Rows[i]["chao_chieu"]; 
			exSheet.Cells[pos + i,34].Value = dt.Rows[i]["banh_chieu"]; 
			exSheet.Cells[pos + i,35].Value = dt.Rows[i]["trung_chieu"]; 
			exSheet.Cells[pos + i,36].Value = dt.Rows[i]["tiec_chieu"]; 
			exSheet.Cells[pos + i,37].Value = dt.Rows[i]["total_chieu"];
			
			exSheet.Cells[pos + i,38].Value = dt.Rows[i]["hq_toi"]; 
			exSheet.Cells[pos + i,39].Value = dt.Rows[i]["lon_toi"]; 
			exSheet.Cells[pos + i,40].Value = dt.Rows[i]["bo_toi"]; 
			exSheet.Cells[pos + i,41].Value = dt.Rows[i]["ga_toi"]; 
			exSheet.Cells[pos + i,42].Value = dt.Rows[i]["ca_toi"]; 
			exSheet.Cells[pos + i,43].Value = dt.Rows[i]["bp_toi"];
			exSheet.Cells[pos + i,44].Value = dt.Rows[i]["cr_toi"]; 
			exSheet.Cells[pos + i,45].Value = dt.Rows[i]["chao_toi"]; 
			exSheet.Cells[pos + i,46].Value = dt.Rows[i]["banh_toi"]; 
			exSheet.Cells[pos + i,47].Value = dt.Rows[i]["trung_toi"]; 
			exSheet.Cells[pos + i,48].Value = dt.Rows[i]["tiec_toi"]; 
			exSheet.Cells[pos + i,49].Value = dt.Rows[i]["total_toi"]; 
			
			exSheet.Cells[pos + i,50].Value = dt.Rows[i]["hq_total"]; 
			exSheet.Cells[pos + i,51].Value = dt.Rows[i]["lon_total"]; 
			exSheet.Cells[pos + i,52].Value = dt.Rows[i]["bo_total"]; 
			exSheet.Cells[pos + i,53].Value = dt.Rows[i]["ga_total"]; 
			exSheet.Cells[pos + i,54].Value = dt.Rows[i]["ca_total"]; 
			exSheet.Cells[pos + i,55].Value = dt.Rows[i]["bp_total"]; 
			exSheet.Cells[pos + i,56].Value = dt.Rows[i]["cr_total"]; 
			exSheet.Cells[pos + i,57].Value = dt.Rows[i]["chao_total"];
			exSheet.Cells[pos + i,58].Value = dt.Rows[i]["banh_total"]; 
			exSheet.Cells[pos + i,59].Value = dt.Rows[i]["trung_total"]; 
			exSheet.Cells[pos + i,64].Value = dt.Rows[i]["tiec_total"];
			
			
			
        }
		// INSERT ROWS
		 
		for (int l_add = 0; l_add < dt1.Rows.Count-1; l_add++)
		{
         exSheet.Range["A10"].Rows.EntireRow.Insert();//insert row new of sheet
		}
						
		// SET DATA
		int k   = 0  ;
		int pos_w=9;
		for (k = 0; k < dt1.Rows.Count; k++)
        {
			exSheet.Cells[pos_w, 1 ].Value = dt1.Rows[k]["week"];
			exSheet.Cells[pos_w, 2 ].Value = dt1.Rows[k]["hq_sang"]; 
			exSheet.Cells[pos_w, 3 ].Value = dt1.Rows[k]["lon_sang"];	
			exSheet.Cells[pos_w, 4].Value = dt1.Rows[k]["bo_sang"];			
			exSheet.Cells[pos_w, 5].Value = dt1.Rows[k]["ga_sang"]; 
			exSheet.Cells[pos_w, 6].Value = dt1.Rows[k]["ca_sang"]; 
			exSheet.Cells[pos_w, 7].Value = dt1.Rows[k]["bp_sang"]; 
			exSheet.Cells[pos_w, 8].Value = dt1.Rows[k]["cr_sang"]; 
			exSheet.Cells[pos_w, 9].Value = dt1.Rows[k]["chao_sang"]; 
			exSheet.Cells[pos_w, 10].Value = dt1.Rows[k]["banh_sang"]; 
			exSheet.Cells[pos_w, 11].Value = dt1.Rows[k]["trung_sang"]; 
			exSheet.Cells[pos_w,12].Value = dt1.Rows[k]["tiec_sang"]; 
			exSheet.Cells[pos_w,13].Value = dt1.Rows[k]["total_sang"]; 
			
			exSheet.Cells[pos_w,14].Value = dt1.Rows[k]["hq_trua"]; 
			exSheet.Cells[pos_w,15].Value = dt1.Rows[k]["lon_trua"]; 
			exSheet.Cells[pos_w,16].Value = dt1.Rows[k]["bo_trua"]; 
			exSheet.Cells[pos_w,17].Value = dt1.Rows[k]["ga_trua"]; 
			exSheet.Cells[pos_w,18].Value = dt1.Rows[k]["ca_trua"]; 
			exSheet.Cells[pos_w,19].Value = dt1.Rows[k]["bp_trua"]; 
			exSheet.Cells[pos_w,20].Value = dt1.Rows[k]["cr_trua"]; 
			exSheet.Cells[pos_w,21].Value = dt1.Rows[k]["chao_trua"]; 
			exSheet.Cells[pos_w,22].Value = dt1.Rows[k]["banh_trua"]; 
			exSheet.Cells[pos_w,23].Value = dt1.Rows[k]["trung_trua"]; 
			exSheet.Cells[pos_w,24].Value = dt1.Rows[k]["tiec_trua"]; 
			exSheet.Cells[pos_w,25].Value = dt1.Rows[k]["total_trua"];
			
			exSheet.Cells[pos_w,26].Value = dt1.Rows[k]["hq_chieu"]; 
			exSheet.Cells[pos_w,27].Value = dt1.Rows[k]["lon_chieu"]; 
			exSheet.Cells[pos_w,28].Value = dt1.Rows[k]["bo_chieu"]; 
			exSheet.Cells[pos_w,29].Value = dt1.Rows[k]["ga_chieu"]; 
			exSheet.Cells[pos_w,30].Value = dt1.Rows[k]["ca_chieu"]; 
			exSheet.Cells[pos_w,31].Value = dt1.Rows[k]["bp_chieu"]; 
			exSheet.Cells[pos_w,32].Value = dt1.Rows[k]["cr_chieu"]; 
			exSheet.Cells[pos_w,33].Value = dt1.Rows[k]["chao_chieu"]; 
			exSheet.Cells[pos_w,34].Value = dt1.Rows[k]["banh_chieu"]; 
			exSheet.Cells[pos_w,35].Value = dt1.Rows[k]["trung_chieu"]; 
			exSheet.Cells[pos_w,36].Value = dt1.Rows[k]["tiec_chieu"]; 
			exSheet.Cells[pos_w,37].Value = dt1.Rows[k]["total_chieu"];
			
			exSheet.Cells[pos_w,38].Value = dt1.Rows[k]["hq_toi"]; 
			exSheet.Cells[pos_w,39].Value = dt1.Rows[k]["lon_toi"]; 
			exSheet.Cells[pos_w,40].Value = dt1.Rows[k]["bo_toi"]; 
			exSheet.Cells[pos_w,41].Value = dt1.Rows[k]["ga_toi"]; 
			exSheet.Cells[pos_w,42].Value = dt1.Rows[k]["ca_toi"]; 
			exSheet.Cells[pos_w,43].Value = dt1.Rows[k]["bp_toi"];
			exSheet.Cells[pos_w,44].Value = dt1.Rows[k]["cr_toi"]; 
			exSheet.Cells[pos_w,45].Value = dt1.Rows[k]["chao_toi"]; 
			exSheet.Cells[pos_w,46].Value = dt1.Rows[k]["banh_toi"]; 
			exSheet.Cells[pos_w,47].Value = dt1.Rows[k]["trung_toi"]; 
			exSheet.Cells[pos_w,48].Value = dt1.Rows[k]["tiec_toi"]; 
			exSheet.Cells[pos_w,49].Value = dt1.Rows[k]["total_toi"]; 
			
			exSheet.Cells[pos_w,50].Value = dt1.Rows[k]["hq_total"]; 
			exSheet.Cells[pos_w,51].Value = dt1.Rows[k]["lon_total"]; 
			exSheet.Cells[pos_w,52].Value = dt1.Rows[k]["bo_total"]; 
			exSheet.Cells[pos_w,53].Value = dt1.Rows[k]["ga_total"]; 
			exSheet.Cells[pos_w,54].Value = dt1.Rows[k]["ca_total"]; 
			exSheet.Cells[pos_w,55].Value = dt1.Rows[k]["bp_total"]; 
			exSheet.Cells[pos_w,56].Value = dt1.Rows[k]["cr_total"]; 
			exSheet.Cells[pos_w,57].Value = dt1.Rows[k]["chao_total"];
			exSheet.Cells[pos_w,58].Value = dt1.Rows[k]["banh_total"]; 
			exSheet.Cells[pos_w,59].Value = dt1.Rows[k]["trung_total"]; 
			exSheet.Cells[pos_w,64].Value = dt1.Rows[k]["tiec_total"];
		}
		
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