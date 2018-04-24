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

public partial class rpt_attendence_absence_n2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser("APP_DBUSER");
        //ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_user, p_tco_org_pk, p_group_pk, p_thr_ws_pk, p_search_by, p_search_temp;
        string p_from_date, p_to_date, p_from_date_text, p_to_date_text, p_date_type, p_foreigner, p_list_k, p_confirm;
                
        p_tco_org_pk = Request["p_tco_org_pk"].ToString();
        p_group_pk = Request["p_wg"].ToString();
        p_date_type = Request["p_date_type"].ToString();
        p_search_by = Request["p_search_by"].ToString();
        p_search_temp = Request["p_search_temp"].ToString();
        p_thr_ws_pk = Request["p_work_shift"].ToString();
        p_from_date = Request["p_from_date"].ToString();
        p_to_date = Request["p_to_date"].ToString();
        p_user = Request["p_user"].ToString();
        p_foreigner = Request["p_nation"].ToString();
        p_list_k = Request["p_reg"].ToString();
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


        string TemplateFile = "rpt_attendence_absence_n2.xls";
        string TempFile = "../../../system/temp/rpt_attendence_absence_n2_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        int i;
        IRange range;

        string SQL
    = " SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy'),c.ORG_NM,gp.WORKGROUP_NM,A.EMP_ID, A.FULL_NAME,GW.WORK_DT,WS.SHIFT,WS.Remark " +
        "       ,WKD.TIME_IN " +
        "       ,WKD.TIME_OUT " +
        "       ,NULLIF(WKD.WORK_TIME,0) " +
        "       ,NULLIF(WKD.OVT,0) " +
        "       ,NULLIF(WKD.HT,0) " +
        "       ,NULLIF(WKD.NT,0) " +
        "       ,NULLIF(WKD.NT2,0)  " + 
        "       ,ABS.CODE  " +
        "       , ABS.ABSENCE_TIME        " +
         "       ,GW.NOTE_ATT " +
        "       ,GW.APPROVE_YN " +
        "      FROM THR_EMPLOYEE A, TCO_ORG C,THR_WORK_GROUP GP,THR_WG_SCH_DETAIL GW,THR_WORK_SHIFT WS, THR_WORK_GROUP GP2" +
         "      ,(select v.code,v.code_nm from vhr_hr_code v where v.id='HR0003') hr_code " +
        "             ,(SELECT D.THR_EMP_PK AS THR_EMP_PK,D.WORK_DT AS W_DATE,MAX( D.TIME_IN) AS TIME_IN, MAX(D.TIME_OUT) AS TIME_OUT, MAX(D.WORK_TIME) AS WORK_TIME " +
        "           ,MAX(D.PK) AS PK,MAX(D.THR_WS_PK) AS THR_WS_PK " +
        "           ,SUM(DECODE(H.OT_TYPE,'OT',NVL(H.OT_TIME,0),0)) AS OVT " +
        "           ,SUM(DECODE(H.OT_TYPE,'NT',NVL(H.OT_TIME,0),0)) AS NT " +
        "           ,SUM(DECODE(H.OT_TYPE,'NT2',NVL(H.OT_TIME,0),0)) AS NT2 " +
        "            ,SUM(DECODE(H.OT_TYPE,'HT',NVL(H.OT_TIME,0),0)) AS HT " +
        "             ,SUM(DECODE(H.OT_TYPE,'OT',H.PK,0)) AS OVT_PK " +
        "             ,SUM(DECODE(H.OT_TYPE,'NT',H.PK,0)) AS NT_PK " +
        "             ,SUM(DECODE(H.OT_TYPE,'NT2',H.PK,0)) AS NT2_PK " +
        "             ,SUM(DECODE(H.OT_TYPE,'HT',H.PK,0)) AS HT_PK " +
        "             ,MAX( D.DATE_IN) AS DATE_IN " +
        "             ,MAX( D.DATE_OUT) AS DATE_OUT " +
        "             ,MAX(DECODE(NVL(D.MOD_BYHAND_YN,'N'),'N',NVL(D.MOD_AUTO_YN,'N'),'Y')) AS BYHAND_YN " +
        "             ,MAX(DECODE(NVL(H.MOD_BYHAND_YN,'N'),'N',NVL(H.MOD_AUTO_YN,'N'),'Y')) AS BYHAND_YN2 " +
        "             ,D.NO_SCAN_FLAG AS NO_SCAN, max(h.OT_PLUS) as OT_PLUS " +
        "                FROM THR_TIME_MACHINE D,THR_EXTRA_TIME H,THR_EMPLOYEE V " +
        "              WHERE D.DEL_IF = 0 AND V.DEL_IF=0  " +
        "              AND H.DEL_IF(+)=0 AND D.THR_EMP_PK=V.PK   " +
        "              AND D.THR_EMP_PK=H.THR_EMP_PK(+) " +
        "              AND D.WORK_DT=H.WORK_DT(+) " +
        "              AND D.WORK_DT BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' " +
        "               AND (DECODE('" + p_search_by + "','1',UPPER(V.EMP_ID),'2',V.ID_NUM,'3',UPPER(V.FULL_NAME)) LIKE '%'||UPPER('" + p_search_temp + "') " +
        "                    OR '" + p_search_temp + "' IS NULL) " +
        "               AND V.TCO_ORG_PK IN ( " +
        "                                  SELECT     G.PK " +
        "                                        FROM TCO_ORG G " +
        "                                       WHERE G.DEL_IF = 0 " +
        "                                  START WITH G.PK =(CASE WHEN '" + p_tco_org_pk + "'='ALL' THEN G.PK ELSE TO_NUMBER('" + p_tco_org_pk + "') END) " +
        "                                  CONNECT BY PRIOR G.PK = G.P_PK) " +
        "              GROUP BY  D.THR_EMP_PK, D.WORK_DT,D.NO_SCAN_FLAG) WKD " +
        "           ,(SELECT E.ABSENCE_DT AS ABS_DATE,E.THR_EMP_PK, E.ABSENCE_TYPE AS CODE, E.ABSENCE_TIME,E.PK " +
        "               FROM THR_ABSENCE E,THR_EMPLOYEE F " +
        "              WHERE E.DEL_IF = 0 AND F.DEL_IF=0  AND F.PK=E.THR_EMP_PK " +
        "                AND E.ABSENCE_DT  BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' " +
        "                   AND (DECODE('" + p_search_by + "','1',UPPER(F.EMP_ID),'2',F.ID_NUM,'3',UPPER(F.FULL_NAME)) LIKE '%'||UPPER('" + p_search_temp + "') " +
        "                    OR '" + p_search_temp + "' IS NULL) " +
        "                AND F.TCO_ORG_PK IN ( " +
        "                                  SELECT     G.PK " +
        "                                        FROM TCO_ORG G " +
        "                                       WHERE G.DEL_IF = 0 " +
        "                                  START WITH G.PK =(CASE WHEN '" + p_tco_org_pk + "'='ALL' THEN G.PK ELSE TO_NUMBER('" + p_tco_org_pk + "') END) " +
        "                                  CONNECT BY PRIOR G.PK = G.P_PK) " +
        "            ) ABS " +
        "     WHERE A.DEL_IF = 0 AND C.DEL_IF=0 AND GP.DEL_IF=0 AND GW.DEL_IF=0 AND WS.DEL_IF=0 AND GP2.DEL_IF=0  " +
        "       AND A.PK=GW.THR_EMP_PK AND GW.THR_WS_PK=WS.PK AND GW.THR_WG_PK=GP2.PK " +
        "       AND NVL(A.OLD_JOIN_DT,A.JOIN_DT) <= '" + p_to_date + "' " +
        "       AND (A.LEFT_DT > TO_CHAR(TO_DATE(GW.WORK_DT,'YYYYMMDD')- " + p_tmp + " ,'YYYYMMDD') OR A.LEFT_DT IS NULL) " +
        "       AND A.TCO_ORG_PK = C.PK AND A.THR_WG_PK=GP.PK " +
        "       AND GW.WORK_DT BETWEEN '" + p_from_date + "' AND '" + p_to_date + "' " +
        "       AND GW.THR_EMP_PK = WKD.THR_EMP_PK(+) " +
        "       AND GW.THR_EMP_PK = ABS.THR_EMP_PK(+) " +
        "       AND GW.WORK_DT=WKD.W_DATE(+) " +
        "       AND GW.WORK_DT=ABS.ABS_DATE(+) " +
         "      AND NVL(ABS.CODE,' ')=HR_CODE.CODE(+)  " +
        "       AND DECODE('" + p_group_pk + "','ALL','" + p_group_pk + "',GP.PK) = '" + p_group_pk + "' " +
        "       AND DECODE('" + p_thr_ws_pk + "','ALL','ALL',WS.PK)='" + p_thr_ws_pk + "' " +
        "       and (decode('" + p_foreigner + "','ALL','ALL',nvl(a.NATION,'01')) = '" + p_foreigner + "'  " +
        "                    or ( '" + p_foreigner + "'='02' and nvl(a.NATION,'01') <> '01' )) " +
        "       AND ('" + p_list_k + "'='ALL' OR A.PK IN(SELECT R.THR_EMP_PK " +
        "                                             FROM THR_REGULATION R  " +
        "                                             WHERE R.DEL_IF=0 AND R.THR_EMP_PK=A.PK " +
        "                                                AND GW.WORK_DT>=R.START_DT AND NVL(R.END_DT,GW.WORK_DT)>=GW.WORK_DT) " +
        "            ) " +
        "       AND C.PK IN ( " +
        "                                  SELECT     G.PK " +
        "                                        FROM TCO_ORG G " +
        "                                       WHERE G.DEL_IF = 0 " +
        "                                  START WITH G.PK =(CASE WHEN '" + p_tco_org_pk + "'='ALL' THEN G.PK ELSE TO_NUMBER('" + p_tco_org_pk + "') END) " +
        "                                  CONNECT BY PRIOR G.PK = G.P_PK) " +
        "       AND A.PK NOT IN(SELECT AB.THR_EMP_PK FROM THR_ABSENCE_REG AB WHERE AB.DEL_IF=0 " +
        "                    AND GW.WORK_DT BETWEEN AB.START_DT AND AB.END_DT AND AB.THR_EMP_PK=A.PK ) " +
        "       AND (DECODE('" + p_search_by + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_search_temp + "') " +
        "                    OR '" + p_search_temp + "' IS NULL) " +
        "       AND DECODE('" + p_confirm + "','ALL','" + p_confirm + "',NVL(GW.APPROVE_YN,'N')) = '" + p_confirm + "'              " +
        "    ORDER BY GW.WORK_DT,C.ORG_NM,A.ID_NUM ";

		
		DataTable dt_total = ESysLib.TableReadOpen(SQL);

		int irow,icol;
        int row_pos = 8;
        irow = dt_total.Rows.Count;
        icol = dt_total.Columns.Count;	
		if (irow == 0)
		{
			Response.Write("Not data to print.");
			Response.End();
		}
			 		 		
		// insert row
	 
		for (i = 0; i < irow-2; i++)
		{
            exSheet.Range[row_pos + i, 1].Rows.EntireRow.Insert();			
		}

        String from_nam = p_from_date.Substring(0, 4);
        String from_thang = p_from_date.Substring(4, 2);
        String from_ngay = p_from_date.Substring(6, 2);

        String to_nam = p_to_date.Substring(0, 4);
        String to_thang = p_to_date.Substring(4, 2);
        String to_ngay = p_to_date.Substring(6, 2);


        String v_dtfrom_date = from_ngay + '/' + from_thang + '/' + from_nam;
        String v_dtto_date = to_ngay + '/' + to_thang + '/' + to_nam;

        exSheet.Cells[2, 3].Value = v_dtfrom_date;
        exSheet.Cells[2, 5].Value = v_dtto_date;
        exSheet.Cells[2, 12].Value = dt_total.Rows[0][0].ToString();
        exSheet.Cells[3, 12].Value = p_user;
        row_pos = 7;

		//Show data		
        for (i = 0; i < irow; i++)
        {
            exSheet.Cells[row_pos + i, 1].Value = i + 1;
            for (int j = 1; j < icol; j++)
            {
                if (j == 10 || j == 11 || j == 12 || j == 13 || j == 14)
                {
                    if (dt_total.Rows[i][j].ToString()!="")
                        exSheet.Cells[row_pos + i, j + 1].Value = Double.Parse(dt_total.Rows[i][j].ToString());
                }
                else
                {
                    exSheet.Cells[row_pos + i, j + 1].Value = dt_total.Rows[i][j].ToString();
                }
            }

        }

	
		// exSheet.Cells["D1:D1"].EntireColumn.Delete();
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