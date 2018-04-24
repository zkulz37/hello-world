using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class rpt_chae00781_employee_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        //url=url + '/reports/ch/ae/'+txtReport_tmp.text+'?TCO_ORG_PK=' + lstOrg_Code.value + '&THR_WG_PK=' + lstGrp_Code.value + '&NATION=' + lst_nation.value;
        string TCO_ORG_PK;
        string THR_WG_PK;
        string NATION;
		int irow; //dòng
		int icol_emp; //cột
		int pos = 6; //position : vị trí con trỏ trong excel 

        TCO_ORG_PK = Request["TCO_ORG_PK"].ToString();
        THR_WG_PK = Request["THR_WG_PK"].ToString();
        NATION = Request["NATION"].ToString();


		//create template file
        string TemplateFile = "rpt_chae00781_employee_list.xls";
        string TempFile = "../../../system/temp/rpt_chae00781_employee_list" + DateTime.Now.ToString("hhmmss") + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;


        string SQL
         = "SELECT A.EMP_ID,            " +
         "             A.FULL_NAME,             " +
         "             A.SEX, " +
         "             B.CODE_NM," +
         "             A.TEL, " +
         "             A.PK, " +
         "             to_char(to_date(A.JOIN_DT,'YYYYMMDD'),'DD-MM-YYYY') as JOIN_DT, " +
         " case when length(A.BIRTH_DT) = 4 then A.BIRTH_DT " +
         " when  length(A.BIRTH_DT) = 6 then to_char(to_date(A.BIRTH_DT,'YYYYMMDD'),'MM-YYYY') " +
         " else to_char(to_date(A.BIRTH_DT,'YYYYMMDD'),'DD-MM-YYYY') " +
         " end as BIRTH_DT " +
         "        FROM THR_EMPLOYEE A " +
         " left join vhr_hr_code B on A.NATION = B.CODE " +
         "       WHERE A.DEL_IF = 0  " +
         " and B.ID = 'HR0009' " +
     " and ( A.TCO_ORG_PK in (select g.pk from tco_org g where g.del_if = 0 " +
     " start with g.pk = decode ('" + TCO_ORG_PK + "','ALL',0,'" + TCO_ORG_PK + "')" +
     " connect by prior g.pk = g.p_pk) or + '" + TCO_ORG_PK + "' = 'ALL' )" +
         "       and decode( '" + THR_WG_PK + "', 'ALL', 'ALL', A.THR_WG_PK ) = '" + THR_WG_PK + "' " +
         "       and decode( '" + NATION + "', 'ALL', 'ALL', A.NATION ) = '" + NATION + "'";

		//Read SQL
        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
 
        irow = dt_emp.Rows.Count; //đếm tổng số dòng
        icol_emp = dt_emp.Columns.Count; //đếm tổng số cột    
        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }

			
        //Insert new row
        for (int i = 0; i < irow - 1; i++)
        {
            exSheet.Range[pos + 1, 1].Rows.EntireRow.Insert();
        }

        //Show data
        for (int i = 0; i < irow; i++)
        {
            exSheet.Cells[pos + i, 1].Value = i + 1; //STT
            for (int j = 0; j < icol_emp; j++)      
                    exSheet.Cells[pos + i,j+2].Value = dt_emp.Rows[i][j].ToString();
        }

       

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
        Response.WriteFile(TempFile);
        //Response.WriteFile(pdfFilePath);
        //Stop execute  
        Response.End();
    }
}