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

using System.Globalization;

public partial class rpt_60090120_inq : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string TemplateFile = "rpt_60090120_inq.xls";
        string TempFile = "../../../system/temp/rpt_60090120_inq_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		
		string p_comp_pk            = Request["p_comp_pk"];
		string p_date_fr            = Request["p_date_fr"];
		string p_date_to            = Request["p_date_to"];
		string p_tco_buspartner_pk  = Request["p_tco_buspartner_pk"];
		string p_tac_abplcenter_pk  = Request["p_tac_abplcenter_pk"];
		string p_acc_pk             = Request["p_acc_pk"];
		string p_slip_no            = Request["p_slip_no"];
		string p_po_no              = Request["p_po_no"];
		
		string para = "'" + p_comp_pk + "','" + p_date_fr + "','" + p_date_to + "','" + p_tco_buspartner_pk + "','" + p_tac_abplcenter_pk + "','" + p_acc_pk + "','" + p_slip_no + "','" + p_po_no + "'";		
		
		string SQL = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE,TCO_BPPHOTO_PK FROM TCO_COMPANY WHERE PK = '" + p_comp_pk + "' ";
		DataTable dtMst = ESysLib.TableReadOpen(SQL);	
		DataTable dtItem = ESysLib.TableReadOpenCursor("ac_sel_60090120_inq", para);		
		
		
		for (int l_addrow = 1; l_addrow < dtItem.Rows.Count; l_addrow++)
		{
			exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
		}
        // MASTER  
		if(dtMst.Rows.Count >0)
		{		
			exSheet.Cells["A1"].Value = "Company Name: "+dtMst.Rows[0]["PARTNER_NAME"];
			exSheet.Cells["A2"].Value = "Address: "+dtMst.Rows[0]["ADDR1"];
			exSheet.Cells["A3"].Value = "Tax Code: "+dtMst.Rows[0]["TAX_CODE"];
		}
		exSheet.Cells["A5"].Value = "Date: "+p_date_fr.Substring(6,2)+"/"+p_date_fr.Substring(4,2)+"/"+p_date_fr.Substring(0,4)+" ~ "+p_date_to.Substring(6,2)+"/"+p_date_to.Substring(4,2)+"/"+p_date_to.Substring(0,4);
		// DETAIL
		decimal qty=0,amt=0;
		string str_qty="",str_amt="";
		CultureInfo elGR = CultureInfo.CreateSpecificCulture("el-GR");
		int i=0;
		if(dtItem.Rows.Count >0)
		{
			for(i=0;i<dtItem.Rows.Count;i++)
			{
				
				exSheet.Range[7+i,1].Value = dtItem.Rows[i]["slip_no"];	
				exSheet.Range[7+i,2].Value = dtItem.Rows[i]["ref_no"];	
				exSheet.Range[7+i,3].Value = dtItem.Rows[i]["in_date"].ToString().Substring(6,2)+"/"+dtItem.Rows[i]["in_date"].ToString().Substring(4,2)+"/"+dtItem.Rows[i]["in_date"].ToString().Substring(0,4);	
				exSheet.Range[7+i,4].Value = dtItem.Rows[i]["item_code"];	
				exSheet.Range[7+i,5].Value = dtItem.Rows[i]["item_name"];
				exSheet.Range[7+i,6].Value = dtItem.Rows[i]["input_qty"] ;
				exSheet.Range[7+i,7].Value = dtItem.Rows[i]["item_amount"];	
				exSheet.Range[7+i,8].Value = dtItem.Rows[i]["voucherno"];	
				exSheet.Range[7+i,9].Value = dtItem.Rows[i]["partner_id"];	
				exSheet.Range[7+i,10].Value = dtItem.Rows[i]["partner_name"];	
				
			}	
			// exSheet.Range[7+i,6].Font.Bold = true;
			// exSheet.Range[7+i,6].NumberFormat = "#,###,###,###.#0";
			// exSheet.Range[7+i,7].Font.Bold = true;
			// exSheet.Range[7+i,7].NumberFormat = "#,###,###,###.#0";
			exSheet.Range[7+i,6].Value = "=sum(F7:F"+(7+dtItem.Rows.Count-1)+")";
			exSheet.Range[7+i,7].Value = "=sum(G7:G"+(7+dtItem.Rows.Count-1)+")";
		}
		exSheet.Cells["A4"].Select();
		
		
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