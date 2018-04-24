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

public partial class rpt_salary_payslip_test : System.Web.UI.Page
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
        int loop_height = 34;
        int loop_width = 5;
        TCO_ORG_PK = Request["TCO_ORG_PK"].ToString();
        THR_WG_PK = Request["THR_WG_PK"].ToString();
        NATION = Request["NATION"].ToString();


        //create template file
        string TemplateFile = "rpt_salary_payslip_test.xls";
        string TempFile = "../../../system/temp/rpt_salary_payslip_test" + DateTime.Now.ToString("hhmmss") + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        //phạm vi
        IRange range;
        IPageBreaks pbs = exSheet.HPageBreaks;
        IRange usedrange = exSheet.UsedRange;
        pbs.Reset();


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
        "       and decode( '" + TCO_ORG_PK + "', 'ALL', 'ALL', A.TCO_ORG_PK ) = '" + TCO_ORG_PK + "' " +
        "       and decode( '" + THR_WG_PK + "', 'ALL', 'ALL', A.THR_WG_PK ) = '" + THR_WG_PK + "' " +
        "       and decode( '" + NATION + "', 'ALL', 'ALL', A.NATION ) = '" + NATION + "'";

        //"             to_char(to_date(A.BIRTH_DT,'YYYYMMDD'),'DD-MM-YYYY') as BIRTH_DT " +
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
      //  for (int i = 0; i < irow - 1; i++)
        //{
          //  exSheet.Range[pos + 1, 1].Rows.EntireRow.Insert();
        //}

        for (int i = 1; i < irow; i++)
        {

            exSheet.Range[1, 1, loop_height, loop_width].Copy(exSheet.Range[(i) * loop_height, 1, (i + 1) * loop_height, loop_width], XlPasteType.xlPasteAll);
            pbs.Add(usedrange.Rows[loop_height * (i)]);
            for (int j = 1; j < loop_width; j++)
            {
                exSheet.Range[(loop_height * i) + j, 1].RowHeight = exSheet.Range[j, 1].RowHeight;
            }
        }




        for (int i = 0; i < irow; i++)
        {
            int row_dis_rel = 0;




            {
                exSheet.Cells["A" + (4 + (loop_height * i))].Value = "Mã NV :" + "EMP_ID";
                exSheet.Cells["A" + (5 + (loop_height * i))].Value = "Ngày vào :" + "JOINT_DT";
                exSheet.Cells["C" + (4 + (loop_height * i))].Value = "Bộ phận :" + "AAA";
                exSheet.Cells["C" + (5 + (loop_height * i))].Value = "Ngày nghỉ việc :" + "1/1/1111";
                //exSheet.Cells["H" + (10 + (loop_height * i) )].Value =	dt_emp.Rows[i]["COL9"].ToString();
                //exSheet.Cells["H" + (11 + (loop_height * i) )].Value =	dt_emp.Rows[i]["COL11"].ToString();
                //exSheet.Cells["H" + (12 + (loop_height * i) )].Value =	dt_emp.Rows[i]["COL13"].ToString();					
                //exSheet.Cells["T" + (8 + (loop_height * i) )].Value =	dt_emp.Rows[i]["COL4"].ToString();
                //exSheet.Cells["T" + (9 + (loop_height * i) )].Value =	dt_emp.Rows[i]["COL7"].ToString();					
                //exSheet.Cells["AD" + (9 + (loop_height * i) )].Value =	dt_emp.Rows[i]["COL8"].ToString();
                //exSheet.Cells["AD" + (10 + (loop_height * i) )].Value =	dt_emp.Rows[i]["COL10"].ToString();					
                //exSheet.Cells["AF" + (11 + (loop_height * i) )].Value =	dt_emp.Rows[i]["COL12"].ToString();
                //exSheet.Cells["AF" + (12 + (loop_height * i) )].Value =	dt_emp.Rows[i]["COL14"].ToString();								
            }
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