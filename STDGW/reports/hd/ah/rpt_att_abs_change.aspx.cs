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

public partial class reports_hd_ah_rpt_att_abs_change : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_user, p_tco_org_pk, p_wg, p_from, p_to, p_search, p_input, p_pos_type, p_mod_type, p_emp_type;

        
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
        string SQL;

        if (p_mod_type == "1")
        {
            SQL = "SELECT B.ORG_NM,C.WORKGROUP_NM,A.EMP_ID,A.FULL_NAME,TO_CHAR(TO_DATE(D.WORK_DT,'yyyymmdd'),'dd/mm/yyyy') " +
             "            ,D.THR_WS_PK,D.CRT_BY,TO_CHAR(D.CRT_DT,'dd/mm/yyyy HH24:MI:SS') " +
             "            ,D.TIME_IN_O,D.TIME_OUT_O,D.WORK_TIME_O,D.OT_O,D.NT_O,D.NT2_O,D.HT_O " +
             "            ,D.TIME_IN,D.TIME_OUT,D.WORK_TIME,D.OT,D.NT,D.NT2,D.HT,D.REMARK " +
             "            ,'',0,'',0,'','','', 1 SEQ " +
             "        FROM THR_EMPLOYEE A,TCO_ORG B,THR_WORK_GROUP C " +
             "            ,THR_ATTENDANCE_MODIFY D,THR_TIME_MACHINE E " +
             "        WHERE A.DEL_IF =0 AND B.DEL_IF = 0 AND C.DEL_IF = 0 AND E.DEL_IF=0 " +
             "        AND D.DEL_IF =0   " +
             "        AND A.TCO_ORG_PK = B.PK " +
             "        AND A.THR_WG_PK = C.PK " +
             "        AND A.PK = E.THR_EMP_PK " +
             "        AND E.THR_EMP_PK = D.THR_EMP_PK " +
             "        AND E.WORK_DT BETWEEN '" + p_from + "' AND '" + p_to + "' " +
             "        AND E.THR_ATTENDANCE_MODIFY_PK=D.PK " +
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
             "        ORDER BY SEQ,D.WORK_DT,B.ORG_NM,A.EMP_ID   ";
        }
        else if (p_mod_type == "2")
        {
            SQL = "SELECT B.ORG_NM,C.WORKGROUP_NM,A.EMP_ID,A.FULL_NAME,TO_CHAR(TO_DATE(D.ABSENCE_DT,'yyyymmdd'),'dd/mm/yyyy') " +
            "            ,D.THR_WS_PK,'','' " +
            "            ,'','','','','','','' " +
            "            ,'','','','','','','','' " +
            "            ,(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0003' AND V.CODE=D.ABSENCE_TYPE_O) " +
            "            ,D.ABSENCE_TIME_O " +
            "            ,(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0003' AND V.CODE=D.ABSENCE_TYPE) BS_TYPE " +
            "            ,D.ABSENCE_TIME ABS_TIME,D.CRT_BY,TO_CHAR(D.CRT_DT,'dd/mm/yyyy HH24:MI:SS'),D.REMARK,1 SEQ " +
            "        FROM THR_EMPLOYEE A,TCO_ORG B,THR_WORK_GROUP C, THR_ABSENCE_MODIFY D,THR_ABSENCE E " +
            "        WHERE A.DEL_IF =0 AND B.DEL_IF = 0 AND C.DEL_IF = 0 AND E.DEL_IF=0  " +
            "        AND D.DEL_IF =0   " +
            "        AND A.TCO_ORG_PK = B.PK " +
            "        AND A.THR_WG_PK = C.PK " +
            "        AND A.PK = E.THR_EMP_PK " +
            "        AND E.THR_EMP_PK=D.THR_EMP_PK " +
            "        AND E.ABSENCE_DT BETWEEN '" + p_from + "' AND '" + p_to + "' " +
            "        AND E.THR_ABSENCE_MODIFY_PK=D.PK " +
            "        AND DECODE('" + p_wg + "','ALL','ALL',C.PK) = '" + p_wg + "' " +
            "        AND DECODE('" + p_pos_type + "','ALL','ALL',A.POS_TYPE) = '" + p_pos_type + "' " +
            "        AND DECODE(P_EMP_TYPE,'ALL','ALL',A.EMPLOYEE_TYPE) = P_EMP_TYPE " +
            "        AND B.PK IN ( " +
            "                                  SELECT     G.PK " +
            "                                        FROM TCO_ORG G " +
            "                                       WHERE G.DEL_IF = 0 " +
            "                                  START WITH G.PK =(CASE WHEN P_TCO_ORG_PK='ALL' THEN G.PK ELSE TO_NUMBER(P_TCO_ORG_PK) END) " +
            "                                  CONNECT BY PRIOR G.PK = G.P_PK) " +
            "        AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
            "                    OR '" + p_input + "' IS NULL) " +
            "        ORDER BY SEQ,D.WORK_DT,B.ORG_NM,A.EMP_ID       ";
        }
        else
        {

            SQL = "SELECT B.ORG_NM,C.WORKGROUP_NM GROUP_NM,A.EMP_ID,A.FULL_NAME,TO_CHAR(TO_DATE(D.WORK_DT,'yyyymmdd'),'dd/mm/yyyy') WORK_DT " +
            "                    ,D.THR_WS_PK,ATT.CRT_BY ATT_MOD_BY,TO_CHAR(ATT.CRT_DT,'dd/mm/yyyy HH24:MI:SS') ATT_MOD_DT " +
            "                    ,ATT.TIME_IN_O,ATT.TIME_OUT_O,ATT.WORK_TIME_O,ATT.OT_O,ATT.NT_O,ATT.NT2_O,ATT.HT_O " +
            "                    ,ATT.TIME_IN,ATT.TIME_OUT,ATT.WORK_TIME,ATT.OT,ATT.NT,ATT.NT2,ATT.HT,ATT.REMARK " +
            "                    ,(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0003' AND V.CODE=AB.ABSENCE_TYPE_O) ABS_TYPE_OLD " +
            "                    ,AB.ABSENCE_TIME_O ABS_TIME_OLD " +
            "                    ,(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0003' AND V.CODE=AB.ABSENCE_TYPE) ABS_TYPE,AB.ABSENCE_TIME ABS_TIME,AB.CRT_BY ABS_MOD_BY,TO_CHAR(AB.CRT_DT,'dd/mm/yyyy HH24:MI:SS'),AB.REMARK,1 SEQ " +
            "                 FROM THR_EMPLOYEE A,TCO_ORG B,THR_WORK_GROUP C, THR_WG_SCH_DETAIL D " +
            "            ,(SELECT T.PK,T.THR_EMP_PK,T.WORK_DT,M.CRT_BY,M.CRT_DT " +
            "                    ,M.TIME_IN_O,M.TIME_OUT_O,M.WORK_TIME_O,M.OT_O,M.NT_O,M.NT2_O,M.HT_O " +
            "                    ,M.TIME_IN,M.TIME_OUT,M.WORK_TIME,M.OT,M.NT,M.NT2,M.HT,M.REMARK   " +
            "                   FROM  THR_TIME_MACHINE T, THR_ATTENDANCE_MODIFY M " +
            "                   WHERE T.DEL_IF=0 AND M.DEL_IF=0 " +
            "                   AND T.THR_EMP_PK=M.THR_EMP_PK " +
            "                   AND T.THR_ATTENDANCE_MODIFY_PK=M.PK " +
            "                   AND T.WORK_DT BETWEEN '" + p_from + "' AND '" + p_to + "' " +
            "                   ) ATT " +
            "                   , " +
            "                   (SELECT K.PK,K.THR_EMP_PK,K.ABSENCE_DT,N.ABSENCE_TYPE_O,N.ABSENCE_TIME_O " +
            "                    ,N.ABSENCE_TYPE,N.ABSENCE_TIME ,N.CRT_BY,N.CRT_DT,N.REMARK " +
            "                   FROM THR_ABSENCE K,THR_ABSENCE_MODIFY N " +
            "                   WHERE K.DEL_IF=0 AND N.DEL_IF=0 " +
            "                   AND K.ABSENCE_DT=N.ABSENCE_DT " +
            "                   AND K.THR_ABSENCE_MODIFY_PK=N.PK " +
            "                   AND K.ABSENCE_DT BETWEEN '" + p_from + "' AND '" + p_to + "') AB " +
            "                WHERE A.DEL_IF =0 AND B.DEL_IF = 0 AND C.DEL_IF = 0 " +
            "                AND D.DEL_IF =0  " +
            "                AND A.TCO_ORG_PK = B.PK " +
            "                AND A.THR_WG_PK = C.PK " +
            "                AND A.PK = D.THR_EMP_PK " +
            "                AND D.THR_EMP_PK = ATT.THR_EMP_PK(+)    " +
            "                AND D.WORK_DT = ATT.WORK_DT(+) " +
            "                AND D.THR_EMP_PK = AB.THR_EMP_PK(+)    " +
            "                AND D.WORK_DT = AB.ABSENCE_DT(+) " +
            "                AND D.WORK_DT BETWEEN '" + p_from + "' AND '" + p_to + "' " +
            "                AND DECODE('" + p_wg + "','ALL','ALL',C.PK) = '" + p_wg + "' " +
            "                AND DECODE('" + p_pos_type + "','ALL','ALL',A.POS_TYPE) = '" + p_pos_type + "' " +
            "                AND DECODE('" + p_emp_type + "','ALL','ALL',A.EMPLOYEE_TYPE) = '" + p_emp_type + "' " +
            "                AND B.PK IN ( " +
            "                                          SELECT     G.PK " +
            "                                                FROM TCO_ORG G " +
            "                                               WHERE G.DEL_IF = 0 " +
            "                                          START WITH G.PK =(CASE WHEN '" + p_tco_org_pk + "'='ALL' THEN G.PK ELSE TO_NUMBER('" + p_tco_org_pk + "') END) " +
            "                                          CONNECT BY PRIOR G.PK = G.P_PK) " +
            "                AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
            "                            OR '" + p_input + "' IS NULL) " +
            "                AND (NVL(ATT.PK,0) + NVL(AB.PK,0)>0)  " +
            "                 " +
            "        ORDER BY SEQ,WORK_DT,ORG_NM,EMP_ID  ";
        }


        //Response.Write(SQL);
        //Response.End();

        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        int irow_emp, icol_emp;
        irow_emp = dt_emp.Rows.Count;
        icol_emp = dt_emp.Columns.Count;

        if (irow_emp == 0)
        {
            Response.Write("There is no data of salary");
            Response.End();
        }


        int i, j, k;

        int pos = 6, p_col = 17;   //cong them 6 cot total phia sau
        
        //bind data to excel file
        exSheet.Cells["C2"].Value = p_user;
        exSheet.Cells["C3"].Value = DateTime.Now.Day + "/" + DateTime.Now.Month + "/" + DateTime.Now.Year;
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
            for (k = 2; k <= icol_emp; k++)    // cong thêm 6 cot total phia sau
            {
                //if (k <= 8)
                exSheet.Cells[pos + i, k].Value = dt_emp.Rows[i][k-2].ToString();
                //else
                //exSheet.Cells[pos + i, k].Value = double.Parse(dt_emp.Rows[i][k].ToString());
            }
        }

        if (p_mod_type == "1")
            exSheet.Cells["Y1", "AE1"].Columns.Hidden = true;
        else if (p_mod_type == "2")
            exSheet.Cells["H1", "X1"].Columns.Hidden = true;


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