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

public partial class rpt_gfbr00040_KEB_GiayLinhTienMat_excel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

         ESysLib.SetUser(Session["APP_DBUSER"].ToString());

		string l_Seq = Request["p_Seq"];
		string p_Date = "";
		string p_Month = "";
		string p_Year = "";
		string p_Amt1 = "";
		string p_D_Acc_Nm = "";
		string p_D_Add = "";
		string p_D_Bank = "";
		string p_C_Acc_No = "";
		string p_C_Acc_Nm = "";
		string p_C_Add = "";
		string p_C_Bank = "";
		string p_Remark = "";
		string p_So = "";

        string TemplateFile = "rpt_gfbr00040_KEB_GiayLinhTienMat_excel.xls";
        string TempFile = "../../../system/temp/rpt_gfbr00040_KEB_GiayLinhTienMat_excel_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
        string para = "";
        DataTable dt, dtSum;
        para = "'" + l_Seq +"'";

        dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", para);


        //-----header---

        //---end--header---
        //--set-----DataBind--in---Master---

        if (dt.Rows.Count == 0)
        {
            exSheet.Cells[3, 3].Value = "There is not data!";

        }
		string _str = "";
    char[] _ch = dt.Rows[0][0].ToString().ToCharArray();
    for (int _j = 0; _j < _ch.Length; _j++)
    {
        _str += _ch[_j] + "<font class=font18><span style='mso-spacerun:yes'>     </span></font>";
    }
    string _str_Cr = "";
    char[] _ch_Cr = dt.Rows[0][0].ToString().ToCharArray();
    for (int _k = 0; _k < _ch_Cr.Length; _k++)
    {
        _str_Cr += _ch_Cr[_k] ;
    }
    //Response.Write(_str_Dr[0]);
    //Response.End();
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    string _str_Amt = "";
   // string p_Amt1 = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", para);
	p_Amt1 = dt_Amount.Rows[0][14].ToString();
		if(dt_Amount.Rows[0][3].ToString()=="VND")//ccy
		{
				if(p_Amt1.Length >=12)
				{
					exSheet.Cells[7, 4].Value = p_Amt1[p_Amt1.Length - 12];
				}
				if(p_Amt1.Length >=11)
				{
					exSheet.Cells[7, 5].Value = p_Amt1[p_Amt1.Length - 11];
				}
				if(p_Amt1.Length >=10)
				{
					exSheet.Cells[7, 6].Value = p_Amt1[p_Amt1.Length - 10];
				}
				if(p_Amt1.Length >=9)
				{
					exSheet.Cells[7, 7].Value = p_Amt1[p_Amt1.Length - 9];
				}
				if(p_Amt1.Length >=8)
				{
					exSheet.Cells[7, 8].Value = p_Amt1[p_Amt1.Length - 8];
				}
				if(p_Amt1.Length >=7)
				{
					exSheet.Cells[7, 9].Value = p_Amt1[p_Amt1.Length - 7];
				}
				if(p_Amt1.Length >=6)
				{
					exSheet.Cells[7, 10].Value = p_Amt1[p_Amt1.Length - 6];
				}
				if(p_Amt1.Length >=5)
				{
					exSheet.Cells[7, 11].Value = p_Amt1[p_Amt1.Length - 5];
				}
				if(p_Amt1.Length >=4)
				{
					exSheet.Cells[7, 12].Value = p_Amt1[p_Amt1.Length - 4];
				}
				if(p_Amt1.Length >=3)
				{
					exSheet.Cells[7, 13].Value = p_Amt1[p_Amt1.Length - 3];
				}
				if(p_Amt1.Length >=2)
				{
					exSheet.Cells[7, 14].Value = p_Amt1[p_Amt1.Length - 2];
				}
				if(p_Amt1.Length >=1)
				{
					exSheet.Cells[7, 15].Value = p_Amt1[p_Amt1.Length - 1];
				}
				exSheet.Cells[7, 16].Value = 0;
				exSheet.Cells[7, 17].Value = 0;
		}
		else//usd
		{
			if(p_Amt1.Length >=15)
			{

				exSheet.Cells[7, 4].Value = p_Amt1[p_Amt1.Length - 15];
			}
			if(p_Amt1.Length >=14)
			{

				exSheet.Cells[7, 5].Value = p_Amt1[p_Amt1.Length - 14];
			}
			if(p_Amt1.Length >=13)
				{

					exSheet.Cells[7, 6].Value = p_Amt1[p_Amt1.Length - 13];
				}

				if(p_Amt1.Length >=12)
				{
					exSheet.Cells[7, 7].Value = p_Amt1[p_Amt1.Length - 12];
				}
				if(p_Amt1.Length >=11)
				{
					exSheet.Cells[7, 8].Value = p_Amt1[p_Amt1.Length - 11];
				}
				if(p_Amt1.Length >=10)
				{
					exSheet.Cells[7, 9].Value = p_Amt1[p_Amt1.Length - 10];
				}
				if(p_Amt1.Length >=9)
				{
					exSheet.Cells[7, 10].Value = p_Amt1[p_Amt1.Length - 9];
				}
				if(p_Amt1.Length >=8)
				{
					exSheet.Cells[7, 11].Value = p_Amt1[p_Amt1.Length - 8];
				}
				if(p_Amt1.Length >=7)
				{
					exSheet.Cells[7, 12].Value = p_Amt1[p_Amt1.Length - 7];
				}
				if(p_Amt1.Length >=6)
				{
					exSheet.Cells[7, 13].Value = p_Amt1[p_Amt1.Length - 6];
				}
				if(p_Amt1.Length >=5)
				{
					exSheet.Cells[7, 14].Value = p_Amt1[p_Amt1.Length - 5];
				}
				if(p_Amt1.Length >=4)
				{
					exSheet.Cells[7, 15].Value = p_Amt1[p_Amt1.Length - 4];
				}
				if(p_Amt1.Length >=2)
				{
					exSheet.Cells[7, 16].Value = p_Amt1[p_Amt1.Length - 2];
				}
				if(p_Amt1.Length >=1)
				{
					exSheet.Cells[7, 17].Value = p_Amt1[p_Amt1.Length - 1];
				}
		}
		//---------------------------------------------------------------
		

    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][11].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();
        p_Amt1 = dt_Amount.Rows[0][14].ToString();

        string _ch_Amt = p_Amt.ToString();

        int p = _ch_Amt.Length % 3;

        if (p > 0)
        {
            _str_Amt = _ch_Amt.Substring(0, p) + "     ";
        }

        int z = _ch_Amt.Length / 3;
        int r;
        for (r = 0; r < z; r++)
        {
            _str_Amt = _str_Amt + _ch_Amt.Substring(p, 3) + " ";
            p = p + 3;

        }

            Inword = CommondLib.Num2EngText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
       }
        string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
        DataTable dt_t = ESysLib.TableReadOpen(SQL3);

        if (dt_t.Rows.Count > 0)
        {
            Inword = dt_t.Rows[0][0].ToString();
        }
        if (dt.Rows.Count > 0)
        {

			exSheet.Cells[3,23].Value = "Ngày/Date: "+dt.Rows[0][10].ToString();  //P_date
			exSheet.Cells[5,2].Value = dt.Rows[0][12].ToString();	//p_D_Acc_Nm
			//exSheet.Cells[9,12].Value = dt.Rows[0][1].ToString();	//p_C_Bank
           	exSheet.Cells[4,2].Value = dt.Rows[0][24].ToString();	//p_D_Acc_No
			p_Remark = dt.Rows[0][13].ToString();
			exSheet.Cells[8,16].Value = p_Ccy;
			exSheet.Cells[10,4].Value = Inword;
			exSheet.Cells[16,1].Value ="Remarks: "+p_Remark;
        }

        //----------------------
        ////end-set-----DataBind--in---Master---


        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        // loop detail not percent

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