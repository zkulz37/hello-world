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

public partial class reports_hd_ah_rpt_att_abs_change_his : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_user, p_tco_org_pk, p_wg, p_from, p_to, p_search, p_input, p_pos_type, p_mod_type, p_emp_type;

        string SQL = "";
        p_tco_org_pk = Request["p_tco_org_pk"].ToString();
        p_wg = Request["p_wg"].ToString();
        p_from = Request["p_from"].ToString();
        p_to = Request["p_to"].ToString();
        p_search = Request["p_search"].ToString();
        p_input = Request["p_input"].ToString();
        p_user = Request["p_user"].ToString();
        p_mod_type = Request["p_mod_type"].ToString();
        p_pos_type = Request["p_pos_type"].ToString();
        p_emp_type = Request["p_emp_type"].ToString();

        string TemplateFile = "rpt_att_abs_change.xls";
        string TempFile = "../../../system/temp/rpt_att_abs_change_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        if (p_mod_type=="1")
        { 
           SQL = "SELECT B.ORG_NM,C.WORKGROUP_NM,A.EMP_ID,A.FULL_NAME,TO_CHAR(TO_DATE(D.WORK_DT,'yyyymmdd'),'dd/mm/yyyy') " +
            "            ,D.THR_WS_PK,D.CRT_BY,TO_CHAR(D.CRT_DT,'dd/mm/yyyy HH24:MI:SS') " +
            "            ,D.TIME_IN_O,D.TIME_OUT_O,D.WORK_TIME_O,D.OT_O,D.NT_O,D.NT2_O,D.HT_O " +
            "            ,D.TIME_IN,D.TIME_OUT,D.WORK_TIME,D.OT,D.NT,D.NT2,D.HT,D.REMARK " +
            "            ,'',0,'',0,'','','' " +
            "        FROM THR_EMPLOYEE A,TCO_ORG B,THR_WORK_GROUP C " +
            "            ,THR_ATTENDANCE_MODIFY D " +
            "        WHERE A.DEL_IF =0 AND B.DEL_IF = 0 AND C.DEL_IF = 0 " +
            "        AND D.DEL_IF =0   " +
            "        AND A.TCO_ORG_PK = B.PK " +
            "        AND A.THR_WG_PK = C.PK " +
            "        AND A.PK = D.THR_EMP_PK " +
            "        AND D.WORK_DT BETWEEN '"+p_from+"' AND '"+p_to+"' " +
            "        AND DECODE('" + p_wg + "','ALL','ALL',C.PK) = '" + p_wg + "' " +
            "        AND DECODE('" + p_pos_type + "','ALL','ALL',A.POS_TYPE) = '" + p_pos_type + "' " +
            "        AND DECODE('" + p_emp_type + "','ALL','ALL',A.EMPLOYEE_TYPE) = '" + p_emp_type + "' " +
            "        AND B.PK IN ( " +
            "                                  SELECT     G.PK " +
            "                                        FROM TCO_ORG G " +
            "                                       WHERE G.DEL_IF = 0 " +
            "                                  START WITH G.PK =(CASE WHEN '" + p_tco_org_pk + "'='ALL' THEN G.PK ELSE TO_NUMBER('" + p_tco_org_pk + "') END) " +
            "                                  CONNECT BY PRIOR G.PK = G.P_PK) " +
            "        AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
            "                    OR '" + p_input + "' IS NULL) " +
            "        ORDER BY WORK_DT,ORG_NM,EMP_ID   ";

        }
        else 
        {
            SQL= "SELECT B.ORG_NM,C.WORKGROUP_NM,A.EMP_ID,A.FULL_NAME,TO_CHAR(TO_DATE(D.ABSENCE_DT,'yyyymmdd'),'dd/mm/yyyy') " +
            "            ,D.THR_WS_PK,'','' " +
            "            ,'','','','','','','' " +
            "            ,'','','','','','','','' " +
            "            ,(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0003' AND V.CODE=D.ABSENCE_TYPE_O) " +
            "            ,D.ABSENCE_TIME_O " +
            "            ,(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0003' AND V.CODE=D.ABSENCE_TYPE) BS_TYPE " +
            "            ,D.ABSENCE_TIME ABS_TIME,D.CRT_BY,TO_CHAR(D.CRT_DT,'dd/mm/yyyy HH24:MI:SS'),D.REMARK " +
            "        FROM THR_EMPLOYEE A,TCO_ORG B,THR_WORK_GROUP C, THR_ABSENCE_MODIFY D " +
            "        WHERE A.DEL_IF =0 AND B.DEL_IF = 0 AND C.DEL_IF = 0   " +
            "        AND D.DEL_IF =0   " +
            "        AND A.TCO_ORG_PK = B.PK " +
            "        AND A.THR_WG_PK = C.PK " +
            "        AND A.PK = D.THR_EMP_PK " +
            "        AND D.ABSENCE_DT BETWEEN '" + p_from + "' AND '" + p_to + "' " +
            "        AND DECODE('" + p_wg + "','ALL','ALL',C.PK) = '" + p_wg + "' " +
            "        AND DECODE('" + p_pos_type + "','ALL','ALL',A.POS_TYPE) = '" + p_pos_type + "' " +
            "        AND DECODE('" + p_emp_type + "','ALL','ALL',A.EMPLOYEE_TYPE) = '" + p_emp_type + "'" +
            "        AND B.PK IN ( " +
            "                                  SELECT     G.PK " +
            "                                        FROM TCO_ORG G " +
            "                                       WHERE G.DEL_IF = 0 " +
            "                                  START WITH G.PK =(CASE WHEN '" + p_tco_org_pk + "'='ALL' THEN G.PK ELSE TO_NUMBER('" + p_tco_org_pk + "') END) " +
            "                                  CONNECT BY PRIOR G.PK = G.P_PK) " +
            "        AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
            "                    OR '" + p_input + "' IS NULL) " +
            "        ORDER BY ABSENCE_DT,ORG_NM,EMP_ID       ";
        }
        
        //Response.Write(SQL);
        //Response.End();

        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        int irow_emp, icol_emp;
        irow_emp = dt_emp.Rows.Count;
        icol_emp = dt_emp.Columns.Count;

        if (irow_emp == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }

        
        int i, j, k;
        int pos = 6;
        
        //bind data to excel file
        

        //---end--header---

       
        //Insert new row

        for (i = 0; i < irow_emp - 1; i++)
        {
            exSheet.Range[pos + 1, 1].Rows.EntireRow.Insert();
        }

        //Show data

        for (i = 0; i < irow_emp; i++)
        {
            exSheet.Cells[pos + i, 1].Value = i + 1;
            for (k = 0; k < icol_emp; k++)    
            {
                if (((k>=10 && k<=14) || (k>=17 && k<=21)) && dt_emp.Rows[i][k].ToString()!="")
                    exSheet.Cells[pos + i, k+2].Value = Double.Parse(dt_emp.Rows[i][k].ToString());
                else
                    exSheet.Cells[pos + i, k + 2].Value = dt_emp.Rows[i][k].ToString();
            }
        }
        if (p_mod_type == "2") //hide attendance modify column
        {
            exSheet.Range["G1:X1"].Columns.EntireColumn.Hidden = true;

        }
        else
        {
            exSheet.Range["Y1:AE1"].Columns.EntireColumn.Hidden = true;
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