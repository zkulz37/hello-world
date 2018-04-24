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

public partial class rpt_gfbr00040_GiayNopTienVaoNganSachNhaNuoc_excel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        string TemplateFile = "rpt_gfbr00040_GiayNopTienVaoNganSachNhaNuoc_excel.xls";
        string TempFile = "../../../system/temp/rpt_gfbr00040_GiayNopTienVaoNganSachNhaNuoc_excel_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
        string p_Seq = Request["Seq"];
		string p_Seq1= Request["Seq1"];
		string p_D_Acc_No = "";
		string p_D_Acc_Nm = "";
		string p_D_Add = "";
		string p_D_Bank = "";
		string p_C_Acc_No = "";
		string p_C_Acc_Nm = "";
		string p_C_Add = "";
		string p_C_Bank = "";
		string p_Remark = "";
		string p_Tax_Code = "";
		string p_Province= "";
		string p_Province_1 = "";
		string p_Date = "";
		string p_Month="";
		string p_Year="";	
    DataTable dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", p_Seq);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    else
    {
        p_D_Acc_No = dt.Rows[0][24].ToString();
        p_D_Acc_Nm = dt.Rows[0][12].ToString();
        p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][13].ToString();
        p_Tax_Code = dt.Rows[0][28].ToString();
        p_Province = dt.Rows[0][22].ToString();
        p_Province_1 = dt.Rows[0][20].ToString();
        p_Date = dt.Rows[0][15].ToString();
        p_Month = dt.Rows[0][16].ToString();
        p_Year = dt.Rows[0][17].ToString();		
    }
	  
    string p_ToKhai = "";
    string p_Ngay = "";
    string p_LoaiXNK = "";
    string p_CQQLT = "";	
	string l_Seq="";
	string l_Seq1="";
	if(p_Seq=="")
	{
		l_Seq="0";
		
	}
	else l_Seq=p_Seq;
	if(p_Seq1=="")
	{
		l_Seq1="0";
	}else l_Seq1=p_Seq1;
    DataTable dt_2 = ESysLib.TableReadOpenCursor("rpt_SEL_gfbr00040_2",l_Seq+","+l_Seq1);
    if (dt_2.Rows.Count > 0)
    {
        p_Ngay = dt_2.Rows[0][0].ToString();
        p_ToKhai = dt_2.Rows[0][1].ToString();
        p_LoaiXNK = dt_2.Rows[0][2].ToString();
        p_CQQLT = dt_2.Rows[0][3].ToString();
    }
   if (dt.Rows.Count > 0)   
	{
			exSheet.Cells[6,3].Value = p_D_Acc_Nm;	//p_D_Acc_Nm
			exSheet.Cells[7,3].Value =p_Tax_Code ;	//p_D_Acc_No	
			exSheet.Cells[7,6].Value =p_D_Add;	    //p_D_Add
			exSheet.Cells[11,3].Value =p_D_Bank;	//p_C_Bank	
			exSheet.Cells[19,2].Value =p_Remark;			
			exSheet.Cells[11,9].Value = p_D_Acc_No;  //p_D_Acc_No
			exSheet.Cells[12,3].Value = p_Province;			
			exSheet.Cells[14,5].Value = p_C_Acc_Nm;	//p_D_Acc_Nm			
    }
	    decimal p_Total_Amt = 0;
		string p_ccy = "";
	   DataTable dt_detail = ESysLib.TableReadOpenCursor("rpt_SEL_gfbr00040_1", l_Seq+","+l_Seq1);
	   for (int l_addrow2 = 1; l_addrow2 < dt_detail.Rows.Count; l_addrow2++)
        {
            exSheet.Range["A20"].Rows.EntireRow.Insert();//insert row new of sheet
        }
	   for (int l_row = 0; l_row < dt_detail.Rows.Count; l_row++)
        {
			if (dt_detail.Rows[l_row]["amount_format"].ToString().Trim() != "")
			 {
				 p_Total_Amt += decimal.Parse(dt_detail.Rows[l_row]["amount_format"].ToString());
			 }
			 else
			 {
				 p_Total_Amt += 0;
			 }
			 exSheet.Cells[19 + l_row, 1].Value = dt_detail.Rows[l_row]["no"].ToString();
			 exSheet.Cells[19 + l_row, 2].Value = dt_detail.Rows[l_row]["REMARK2"].ToString();
			 exSheet.Cells[19 + l_row, 5].Value = dt_detail.Rows[l_row]["Ma_chuong"].ToString();
			 exSheet.Cells[19 + l_row, 6].Value = dt_detail.Rows[l_row]["ma_nganh"].ToString();
			 exSheet.Cells[19 + l_row, 8].Value = dt_detail.Rows[l_row]["Ma_NDKT"].ToString();
			 exSheet.Cells[19 + l_row, 9].Value = dt_detail.Rows[l_row]["Ky_Thue"].ToString();
			 exSheet.Cells[19 + l_row, 10].Value = dt_detail.Rows[l_row]["amount_format"].ToString();
			exSheet.Range[19 + l_row,2,19 + l_row,3].Merge(); 
			exSheet.Range[19 + l_row,6,19 + l_row,7].Merge(); 
			exSheet.Range[19 + l_row,10,19 + l_row,11].Merge(); 
			//exSheet.Range[19 + l_row,10].VerticalAlignment = XlVAlign.xlVAlignLeft;
		}
		int tt = 0;
		if(dt_detail.Rows.Count>1)
		{
			tt = dt_detail.Rows.Count-1;
		}
		else
		{
			tt=0;
		}
		exSheet.Cells[20 + tt, 10].Value = p_Total_Amt;
		exSheet.Cells[30 + tt, 7].Value = "Ngày.."+ p_Date + "..tháng.."+ p_Month + "..năm.."+ p_Year+"..";
		//Response.Write(p_Total_Amt);
		//Response.End();
	   string Inword = "";
     string p_Amt="";
      p_Amt = System.Convert.ToString(p_Total_Amt) ;
      Inword = CommondLib.Num2VNText(p_Amt, p_ccy);
      string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
      DataTable dt_t = ESysLib.TableReadOpen(SQL3);

      if (dt_t.Rows.Count > 0)
      {
          Inword = dt_t.Rows[0][0].ToString();
      }
	   exSheet.Cells[21+tt,1].Value = "Tổng số tiền ghi bằng chữ: "+Inword;
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        range = exSheet.Range["A1"];
        // hide row A5 
       // range.Rows.Hidden = true;
        // font bold header
        exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        //string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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