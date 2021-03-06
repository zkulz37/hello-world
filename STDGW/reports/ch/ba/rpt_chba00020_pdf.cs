﻿using NativeExcel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class rpt_chba00020_pdf : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser("APP_DBUSER");


        string p_user, p_tco_org_pk, p_wg, p_work_shift, p_search_by, p_search_temp;
        string p_from_date, p_to_date, p_from_date_text, p_to_date_text, p_date_type, p_nation, p_reg, p_data_type,p_confirm;


        p_tco_org_pk = Request["p_tco_org_pk"].ToString();
        p_wg = Request["p_wg"].ToString();
        p_date_type = Request["p_date_type"].ToString();
        p_search_by = Request["p_search_by"].ToString();
        p_search_temp = Request["p_search_temp"].ToString();
        p_work_shift = Request["p_work_shift"].ToString();
        p_from_date = Request["p_from_date"].ToString();
        p_to_date = Request["p_to_date"].ToString();
        p_user = Request["p_user"].ToString();
        p_nation = Request["p_nation"].ToString();
        p_reg = Request["p_reg"].ToString();
        p_data_type = Request["p_data_type"].ToString();
        p_confirm = Request["p_confirm"].ToString();

        int p_tmp;

        string SQL_Com
        = "SELECT A.NUM_4 FROM VHR_HR_CODE A " +
            " WHERE A.ID='HR0006' AND A.CODE='11'";

        DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
        int irow_com;
        irow_com = dt_Com.Rows.Count;
        if (irow_com == 0)
            p_tmp = 0;
        else
            p_tmp = int.Parse(dt_Com.Rows[0][0].ToString());

        string SQL="";

        #region statement query

        SQL
        = "SELECT c.ORG_NM C0,A.EMP_ID C1, A.FULL_NAME C2,TO_CHAR(TO_DATE(GW.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY') C3  " +
        ",(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0003' AND V.CODE=ABS.CODE) C4  " +
        "       , NULLIF(ABS.ABSENCE_TIME,0) c5,WS.REMARK C6 " +
        "       ,WKD.TIME_IN C7 " +
        "       ,(CASE WHEN WKD.TEMP_OUT IS NULL THEN WKD.TIME_OUT " +
        "             ELSE WKD.TEMP_OUT END) C8 " +
        "       ,WKD.TEMP_IN C9 " +
        "       ,(CASE WHEN WKD.TEMP_OUT IS NULL THEN NULL " +
        "             ELSE WKD.TIME_OUT END) C10       " +
        "       ,(CASE WHEN NVL(ABS.COMPANY_PAY,'N')='Y' THEN NVL(WKD.WORK_TIME,0)+NVL(ABS.ABSENCE_TIME,0) ELSE  NULLIF(WKD.WORK_TIME,0) END) C11  " +
        "       ,NULLIF(WKD.OVT,0) C12,NULLIF(WKD.ST,0) C13,NULLIF(WKD.NT,0) C14,NULLIF(WKD.NT2,0) C15,NULLIF(WKD.HT,0) C16 " +
        "      FROM THR_EMPLOYEE A, TCO_ORG C,THR_WORK_GROUP GP,THR_WG_SCH_DETAIL GW,THR_WORK_SHIFT WS " +
        "             ,(SELECT D.THR_EMP_PK AS THR_EMP_PK,D.WORK_DT AS W_DATE,MAX( D.TIME_IN) AS TIME_IN, MAX(D.TIME_OUT) AS TIME_OUT, MAX(D.WORK_TIME) AS WORK_TIME " +
        "           ,MAX(D.PK) AS PK,MAX(D.THR_WS_PK) AS THR_WS_PK " +
        "           ,SUM(CASE WHEN H.OT_TYPE='OT' AND H.HOL_TYPE IS NULL THEN NVL(H.OT_TIME,0) " +
        "                     ELSE 0 END) OVT " +
        "           ,SUM(CASE WHEN H.OT_TYPE IN('OT','HT') AND NVL(H.HOL_TYPE,'NOR')='SUN' THEN NVL(H.OT_TIME,0) " +
        "                     ELSE 0 END) ST " +
        "           ,SUM(CASE WHEN H.OT_TYPE ='NT' THEN NVL(H.OT_TIME,0) " +
        "                     ELSE 0 END) NT " +
        "           ,SUM(CASE WHEN H.OT_TYPE ='NT2' THEN NVL(H.OT_TIME,0) " +
        "                     ELSE 0 END) NT2 " +
        "           ,SUM(CASE WHEN H.OT_TYPE IN('OT','HT') AND NVL(H.HOL_TYPE,'NOR')='HOL' THEN NVL(H.OT_TIME,0) " +
        "                     ELSE 0 END) HT " +
        "             ,MAX( D.DATE_IN) AS DATE_IN " +
        "             ,MAX( D.DATE_OUT) AS DATE_OUT " +
        "             ,MAX(D.TEMP_OUT) TEMP_OUT,MAX(D.TEMP_IN) TEMP_IN,MAX(D.TEMP_OUT2) TEMP_OUT2,MAX(D.TEMP_IN2) TEMP_IN2 " +
        "             ,MAX(D.TEMP_WT) TEMP_WT,MAX(D.TEMP_OT) TEMP_OT " +
        "             ,MAX(D.TEMP_NT) TEMP_NT,MAX(D.TEMP_NT2) TEMP_NT2,MAX(D.TEMP_HT) TEMP_HT "+
        "                FROM THR_TIME_MACHINE D,THR_EXTRA_TIME H,THR_EMPLOYEE V " +
            "              WHERE D.DEL_IF = 0 AND V.DEL_IF=0  " +
            "              AND H.DEL_IF(+)=0 AND D.THR_EMP_PK=V.PK   " +
            "              AND D.THR_EMP_PK=H.THR_EMP_PK(+) " +
            "              AND D.WORK_DT=H.WORK_DT(+) " +
            "              AND D.WORK_DT BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' " +
            "     AND (   DECODE ('" + p_search_by + "', '1', UPPER (v.emp_id), '2', v.id_num, '3', UPPER (v.full_name)) LIKE '%' || UPPER ('" + p_search_temp + "') " +
            "          OR '" + p_search_temp + "' IS NULL ) " +
            "               AND V.TCO_ORG_PK IN ( " +
            "                                  SELECT     G.PK " +
            "                                        FROM TCO_ORG G " +
            "                                       WHERE G.DEL_IF = 0 " +
            "                                  START WITH G.PK =(CASE WHEN '" + p_tco_org_pk + "'='ALL' THEN G.PK ELSE TO_NUMBER('" + p_tco_org_pk + "') END) " +
            "                                  CONNECT BY PRIOR G.PK = G.P_PK) " +
            "              GROUP BY  D.THR_EMP_PK, D.WORK_DT,D.NO_SCAN_FLAG) WKD " +
            "           ,(SELECT E.ABSENCE_DT AS ABS_DATE,E.THR_EMP_PK, E.ABSENCE_TYPE AS CODE, E.ABSENCE_TIME,E.PK,NVL(E.COMPANY_PAY_YN,'N') COMPANY_PAY " +
            "               FROM THR_ABSENCE E,THR_EMPLOYEE F " +
            "              WHERE E.DEL_IF = 0 AND F.DEL_IF=0  AND F.PK=E.THR_EMP_PK " +
            "                AND E.ABSENCE_DT  BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' " +
           "     AND (   DECODE ('" + p_search_by + "', '1', UPPER (f.emp_id), '2', f.id_num, '3', UPPER (f.full_name)) LIKE '%' || UPPER ('" + p_search_temp + "') " +
            "          OR '" + p_search_temp + "' IS NULL ) " +
            "                AND F.TCO_ORG_PK IN ( " +
            "                                  SELECT     G.PK " +
            "                                        FROM TCO_ORG G " +
            "                                       WHERE G.DEL_IF = 0 " +
            "                                  START WITH G.PK =(CASE WHEN '" + p_tco_org_pk + "'='ALL' THEN G.PK ELSE TO_NUMBER('" + p_tco_org_pk + "') END) " +
            "                                  CONNECT BY PRIOR G.PK = G.P_PK) " +
            "            ) ABS " +
            "     WHERE A.DEL_IF = 0 AND C.DEL_IF=0 AND GP.DEL_IF=0 AND GW.DEL_IF=0 AND WS.DEL_IF=0  " +
            "       AND A.PK=GW.THR_EMP_PK AND GW.THR_WS_PK=WS.PK  " +
            "       AND NVL(A.OLD_JOIN_DT,A.JOIN_DT) <= '" + p_to_date + "' " +
            "       AND (A.LEFT_DT > TO_CHAR(TO_DATE(GW.WORK_DT,'YYYYMMDD')-'" + p_tmp + "','YYYYMMDD') OR A.LEFT_DT IS NULL) " +
            "       AND A.TCO_ORG_PK = C.PK AND A.THR_WG_PK=GP.PK " +
            "       AND GW.WORK_DT BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' " +
            "       AND GW.THR_EMP_PK = WKD.THR_EMP_PK(+) " +
            "       AND GW.THR_EMP_PK = ABS.THR_EMP_PK(+) " +
            "       AND GW.WORK_DT=WKD.W_DATE(+) " +
            "       AND GW.WORK_DT=ABS.ABS_DATE(+) " +
              "     AND DECODE ('" + p_wg + "', 'ALL', '" + p_wg + "', GP.PK) = '" + p_wg + "'" +
            "   AND DECODE ('" + p_work_shift + "', 'ALL', '" + p_work_shift + "', WS.PK) = '" + p_work_shift + "'" +
            "   AND DECODE ('" + p_nation + "', 'ALL', '" + p_nation + "', a.nation) = '" + p_nation + "'" +
            "   AND ('" + p_reg + "'='ALL' OR A.PK IN(SELECT R.THR_EMP_PK " +
            "                                         FROM THR_REGULATION R  " +
            "                                         WHERE R.DEL_IF=0 AND R.THR_EMP_PK=A.PK " +
            "                                            AND GW.WORK_DT>=R.START_DT AND NVL(R.END_DT,GW.WORK_DT)>=GW.WORK_DT) " +
            "        ) " +
            "       AND C.PK IN ( " +
            "                                  SELECT     G.PK " +
            "                                        FROM TCO_ORG G " +
            "                                       WHERE G.DEL_IF = 0 " +
            "                                  START WITH G.PK =(CASE WHEN '" + p_tco_org_pk + "'='ALL' THEN G.PK ELSE TO_NUMBER('" + p_tco_org_pk + "') END) " +
            "                                  CONNECT BY PRIOR G.PK = G.P_PK) " +
            "       AND A.PK NOT IN(SELECT AB.THR_EMP_PK FROM THR_ABSENCE_REG AB WHERE AB.DEL_IF=0 " +
            "                    AND GW.WORK_DT BETWEEN AB.START_DT AND AB.END_DT AND AB.THR_EMP_PK=A.PK ) " +
            "     AND (   DECODE ('" + p_search_by + "', '1', UPPER (a.emp_id), '2', a.id_num, '3', UPPER (a.full_name)) LIKE '%' || UPPER ('" + p_search_temp + "') " +
            "          OR '" + p_search_temp + "' IS NULL ) " +
            " and decode('" + p_confirm + "','ALL','ALL',nvl(GW.APPROVE_YN,'N')) = '" + p_confirm + "'   " +
            "    ORDER BY A.EMP_ID,GW.WORK_DT,C.ORG_NM ";



        #endregion
        //Response.Write(SQL);
        //Response.End();
        DataTable dt_total = ESysLib.TableReadOpen(SQL);
        int irow, icol;
        irow = dt_total.Rows.Count;
        icol = dt_total.Columns.Count;
        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }


        string TemplateFile = "rpt_chba00020_pdf.xls";
        string TempFile = "../../../system/temp/rpt_chba00020_pdf_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets["Sheet1"];
        //begin export data here
        int pos = 9;
        int i,tmp;
        double[] grant_total = new double[icol + 1];
        for (int k = 0; k < icol; k++)
        {
            grant_total[k] = 0;
        }

        tmp = 0;

        for (i = 0; i < irow - 1; i++)
        {
            if (dt_total.Rows[i][1].ToString() != dt_total.Rows[i + 1][1].ToString() && dt_total.Rows[i][0].ToString() != dt_total.Rows[i + 1][0].ToString())
                tmp+=2;
            else if (dt_total.Rows[i][1].ToString() != dt_total.Rows[i + 1][1].ToString())
                tmp += 1;

        }

        //if(tmp>3)
        //    tmp-=3;

        //Insert new row
        for (i = 0; i < irow - 1+tmp; i++)
        {
            exSheet.Range[pos + i+ 1, 1].Rows.EntireRow.Insert();
        }
        tmp = 0;

        //begin export data here
        exSheet.Cells["E2"].Value ="Ngày in :" + DateTime.Now.ToString("dd/MM/yyyy");

       for (i = 0; i < irow; i++)
        {

            if (i == 0)//nguoi dau tien
            {
                exSheet.Cells["A7"].Value = dt_total.Rows[i][0].ToString();
                exSheet.Cells["B8"].Value = dt_total.Rows[i][1].ToString();
                exSheet.Cells["C8"].Value = dt_total.Rows[i][2].ToString();
            }
            for (int j = 0; j < icol; j++)
            {
                if(j==5|| (j >= 11 && j <= 16))
                {
                    if (dt_total.Rows[i][j].ToString() != "")
                    {
                        exSheet.Cells[pos + i+tmp, j -2].Value = double.Parse(dt_total.Rows[i][j].ToString());
                        grant_total[j] += double.Parse(dt_total.Rows[i][j].ToString());
                    }
                }
                else if(j>=3)
                {
                    exSheet.Cells[pos + i+tmp, j -2].Value = dt_total.Rows[i][j].ToString();
                }
            }

            if (i < irow - 1)
            {

                if (dt_total.Rows[i][1].ToString() != dt_total.Rows[i + 1][1].ToString() && dt_total.Rows[i][0].ToString() != dt_total.Rows[i + 1][0].ToString())
                {

                    exSheet.Range["A7:N8"].Copy(exSheet.Range["A" + (pos + i + tmp + 1) + ":N" + (pos + i + tmp + 2)], XlPasteType.xlPasteAll);
                    exSheet.Cells["A" + (pos + i + tmp + 1)].Value = dt_total.Rows[i+1][0].ToString();
                    exSheet.Cells["B" + (pos + i + tmp + 2)].Value = dt_total.Rows[i+1][1].ToString();
                    exSheet.Cells["C" + (pos + i + tmp + 2)].Value = dt_total.Rows[i + 1][2].ToString();
                    tmp += 2;
                }
                else if (dt_total.Rows[i][1].ToString() != dt_total.Rows[i + 1][1].ToString())
                {
                    exSheet.Range["A7:N7"].Copy(exSheet.Range["A" + (pos + i + tmp + 1) + ":N" + (pos + i + tmp + 1)], XlPasteType.xlPasteAll);
                    exSheet.Cells["A" + (pos + i + tmp + 1)].Value = "";
                    exSheet.Cells["B" + (pos + i + tmp + 1)].Value = dt_total.Rows[i + 1][1].ToString();
                    exSheet.Cells["C" + (pos + i + tmp + 1)].Value = dt_total.Rows[i + 1][2].ToString();
                    exSheet.Cells["B" + (pos + i + tmp + 1)].Rows.Font.Bold = true;
                    exSheet.Cells["C" + (pos + i + tmp + 1)].Rows.Font.Bold = true;
                    tmp += 1;
                }
            }
           
        }

        for (int j = 0; j < icol; j++)
        {
            if (j == 5 || (j >= 11 && j <= 16))
                exSheet.Cells[pos + irow+tmp, j -2].Value = grant_total[j];
        }
        
        //end export data
        exBook.SaveAs(TempFile);
        ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");

        //write out to client broswer
         //System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        System.IO.FileInfo file = new System.IO.FileInfo(pdfFilePath);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        //Response.ContentType = "application/ms-exSheet";
       Response.ContentType = "application/pdf";
        //Send file string to client 
        //Response.WriteFile(TempFile);
        Response.WriteFile(pdfFilePath);
        //Stop execute  
        Response.End();
    }
}