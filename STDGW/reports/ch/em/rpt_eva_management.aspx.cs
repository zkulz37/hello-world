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

public partial class rpt_eva_management : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_eva_master_pk = Request["p_eva_master_pk"].ToString();
        string p_org_pk = Request["p_org_pk"].ToString();
        string p_lst = Request["p_lst"].ToString();
        string p_temp = Request["p_temp"].ToString();
		string	p_wg= Request["p_wg"].ToString();
        string TemplateFile = "rpt_eva_management.xls";
        string TempFile = "../../../system/temp/rpt_eva_management" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        
      string SQL
	= "select g.org_nm,e.emp_id,full_name,to_char(to_date(e.join_dt,'yyyymmdd'),'dd/mm/yyyy'),(select V.CODE_NM from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE )  " + 
        ",A.ABILITY_SCORE,A.ABILITY_RESULT,A.OTHER_SCORE1,A.OTHER_SCORE2,A.OTHER_SCORE3 " +
        "     ,nvl(A.OTHER_SCORE1,0)+nvl(A.OTHER_SCORE2,0)+nvl(A.OTHER_SCORE3,0) other_total " +
        "     ,A.QSS_SCORE,A.QSS_REMARK " +
        "     ,A.REWARD_SCORE,A.REWARD_REMARK " +
        "     ,nvl(A.OTHER_SCORE1,0)+nvl(A.OTHER_SCORE2,0)+nvl(A.OTHER_SCORE3,0)+nvl(A.QSS_SCORE,0)+nvl(A.ABILITY_SCORE,0)+nvl(A.REWARD_SCORE ,0) total " +
        "     from thr_eva_emp a, thr_employee e, thr_eva_master b,tco_org g " +
        "     where a.del_if=0 and e.del_if=0 and b.del_if=0 and g.del_if=0 and g.pk=e.tco_org_pk " +
        "     and A.THR_EVA_MASTER_PK=b.pk and b.pk= "+p_eva_master_pk+" " +
        "     and A.THR_EMPLOYEE_PK=e.pk " +
        "      AND DECODE ('"+p_wg+"','ALL','"+p_wg+"',e.thr_wg_pk)='"+p_wg+"' " +
        "      AND (e.tco_org_pk IN ( SELECT     G.PK " +
        "                                    FROM TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK = " +
        "                                            DECODE ('"+p_org_pk+"', " +
        "                                                    'ALL', 0, " +
        "                                                    '"+p_org_pk+"' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                OR '"+p_org_pk+"' = 'ALL' " +
        "           ) " +
        "     AND UPPER(DECODE('"+p_lst+"',1,E.emp_id,2,E.id_num,E.full_name)) LIKE '%' || UPPER ('"+p_temp+"') || '%'  order by org_nm,2 " ;



        //Response.Write(SQL);
        //Response.End();

        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        int irow, icol;
        irow = dt_emp.Rows.Count;
        icol = dt_emp.Columns.Count;

        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }

        SQL
        = "SELECT EVA_YYYY || '-' || EVA_SEQ times_eva" +
        "  FROM THR_EVA_MASTER " +
        " WHERE DEL_IF = 0 AND PK = '" + p_eva_master_pk + "' ";

        DataTable dt_time_eva = ESysLib.TableReadOpen(SQL);


        int i, j, k, i_allow;
        int pos = 7;
        
        //bind data to excel file
        //-----header---   

        exSheet.Cells["G3"].Value = "[Times: " + dt_time_eva.Rows[0][0].ToString() +"]";


        //---end--header---
        //Insert new row

        for (i = 0; i < irow - 1; i++)
        {
            exSheet.Range[pos + 1, 1].Rows.EntireRow.Insert();
        }

        //Show data
        for (i = 0; i < irow; i++)
        {
            exSheet.Cells[pos + i, 1].Value = i + 1;
            for (j = 0; j < icol; j++)
                exSheet.Cells[pos + i, j+2].Value = dt_emp.Rows[i][j].ToString();

        }


        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }



        // hide row firts 

        //range = exSheet.Range["A1"];
        // hide row A5 
        //range.Rows.Hidden = true;

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