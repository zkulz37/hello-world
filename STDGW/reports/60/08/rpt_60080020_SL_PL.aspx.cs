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

public partial class rpt_60080020_SL_PL : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        string TemplateFile = "rpt_60080020_SL_PL.xls";
        string TempFile = "../../../system/temp/rpt_60080020_SL_PL_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
		string p_compk = ""+Request["p_compk"];
		string p_from = ""+Request["p_from"];
		string p_to= ""+Request["p_to"];
		string p_acc_pk = ""+Request["p_acc_pk"];
		string p_plcenter = ""+Request["p_plcenter"];
		string p_plunit = ""+Request["p_plunit"];
		string p_status = ""+Request["p_status"];	
		string p_ccy = ""+Request["p_ccy"];	
        int i = 0;
		string para="'" + p_compk + "','" + p_from  + "','" + p_to + "','" + p_acc_pk + "' ,'" + p_plcenter + "','" + p_plunit + "','" + p_status + "','" + p_ccy + "'";
		DataTable dt = ESysLib.TableReadOpenCursor("ac_rpt_60080200_SL_PL",para);
		
		
		//Response.Write(dt.Rows.Count);
		//Response.End();
		
		int cnt=0;
		cnt=dt.Rows.Count; 
		double 	l_opening_bal=0, l_ymd_drbooks=0, l_ymd_crtrans=0, l_end_balance=0;
        if (dt.Rows.Count > 0)
        {			
			exSheet.Cells[7,3].Value = dt.Rows[0]["paradate"].ToString();
			exSheet.Cells[8,2].Value = dt.Rows[0]["plc_cd"].ToString();
			exSheet.Cells[8,4].Value =dt.Rows[0]["pl_cd"].ToString();//dt.Rows[0]["p_plunit"].ToString();
			exSheet.Cells[8,6].Value =dt.Rows[0]["status_name"].ToString();
			exSheet.Cells[8,9].Value = dt.Rows[0]["ac_cd"].ToString();
		} 
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A11"].Rows.EntireRow.Insert();//insert row new of sheet
        }        
        for (int l_row = 1; l_row <= dt.Rows.Count; l_row++)
        {
            for (int col = 0; col <= 12; col++)
			{ 
				if( col==0)
                {
					exSheet.Cells[9 + l_row,1].Value = dt.Rows[l_row - 1]["std_ymd"].ToString();
					
				}
				if( col==1)
                {
					exSheet.Cells[9 + l_row,2].Value = dt.Rows[l_row - 1]["ac_cd"].ToString();
					
				}
				if( col==2)
                {
					exSheet.Cells[9 + l_row,3].Value = dt.Rows[l_row - 1]["ac_nm"].ToString();
					
				}
				if( col==3)
                {
					exSheet.Cells[9 + l_row,4].Value = dt.Rows[l_row - 1]["ccy"].ToString();
					
				}
				if( col==4)
                {	if(dt.Rows[l_row - 1]["opening_bal"].ToString()!="")
					{
						exSheet.Cells[10,5].Value = double.Parse(dt.Rows[l_row - 1]["opening_bal"].ToString()); 
						exSheet.Cells[10+l_row,5].Value = double.Parse(dt.Rows[l_row - 1]["end_balance"].ToString()); 
						//exSheet.Cells[9 + l_row,5].Value = double.Parse(dt.Rows[l_row ]["end_balance"].ToString()); 	// 	grdVoucher.SetGridText(i,8,grdVoucher.GetGridData(i-1,13));
						//l_opening_bal=l_opening_bal+double.Parse(dt.Rows[l_row - 1]["opening_bal"].ToString());
					}
				} 
				if( col==5)
                {	if(dt.Rows[l_row - 1]["ymd_drbooks"].ToString()!="")
					{
						exSheet.Cells[9 + l_row,6].Value = double.Parse(dt.Rows[l_row - 1]["ymd_drbooks"].ToString());
						l_ymd_drbooks=l_ymd_drbooks+double.Parse(dt.Rows[l_row - 1]["ymd_drbooks"].ToString());
					}	
				}
				
				if( col==6)
                {	if(dt.Rows[l_row - 1]["ymd_crtrans"].ToString()!="")
					{
						exSheet.Cells[9 + l_row,7].Value = double.Parse(dt.Rows[l_row - 1]["ymd_crtrans"].ToString());
						l_ymd_crtrans=l_ymd_crtrans+double.Parse(dt.Rows[l_row - 1]["ymd_crtrans"].ToString());
					}
				}
				if( col==7)
                {	if(dt.Rows[l_row - 1]["end_balance"].ToString()!="")
					{
						exSheet.Cells[9 + l_row,8].Value = double.Parse(dt.Rows[l_row - 1]["end_balance"].ToString());
						l_end_balance=l_end_balance+double.Parse(dt.Rows[l_row - 1]["end_balance"].ToString());
					}	
				}
				if( col==8)
               
				{
					exSheet.Cells[9 + l_row,9].Value = dt.Rows[l_row - 1]["pl_cd"].ToString();
				}	
				
				if( col==9)
                {
					exSheet.Cells[9 + l_row,10].Value = dt.Rows[l_row - 1]["pl_nm"].ToString();
					
				}
				if( col==10)
                {
					exSheet.Cells[9 + l_row,11].Value = dt.Rows[l_row - 1]["plc_cd"].ToString();
					
				}
				if( col==11)
                {
					exSheet.Cells[9 + l_row,12].Value =dt.Rows[l_row - 1]["plc_nm"].ToString();
					
				}
					
			}
		}
		
		DataTable dt_Total = ESysLib.TableReadOpenCursor("ac_sel_60080200_plsum",para);
		if(dt_Total.Rows.Count>0)
		{
			exSheet.Cells[10 + cnt,5].Value =dt_Total.Rows[1][2];
			exSheet.Cells[10 + cnt,6].Value =dt_Total.Rows[1][5];
			exSheet.Cells[10 + cnt,7].Value =dt_Total.Rows[1][6];
			exSheet.Cells[10 + cnt,8].Value =dt_Total.Rows[1][12];
		}
		//l_opening_bal=0, l_ymd_drbooks=0, l_ymd_crtrans=0, l_end_balance=0
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        exBook.SaveAs(TempFile);
        ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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
        Response.WriteFile(TempFile);
        //Response.WriteFile(pdfFilePath);
        //Stop execute  
        Response.End();

    }
}
