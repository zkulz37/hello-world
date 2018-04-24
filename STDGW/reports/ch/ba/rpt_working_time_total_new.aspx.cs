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

public partial class rpt_working_time_total_new : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ESysLib.SetUser("hr");
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_user, p_tco_org_pk, p_wg, p_opt, p_wt_ot, p_search, p_input, p_val;
        string p_from, p_to, p_nation;


        p_tco_org_pk = Request["p_tco_org_pk"].ToString();
        p_wg = Request["p_wg"].ToString();
        p_from = Request["p_from"].ToString();
        p_to = Request["p_to"].ToString();
        p_opt = Request["p_opt"].ToString();
        p_wt_ot = Request["p_wt_ot"].ToString();
        p_search = Request["p_search"].ToString();
        p_input = Request["p_input"].ToString();
        p_user = Request["p_user"].ToString();
        p_nation = Request["p_nation"].ToString();
        p_val = Request["p_val"].ToString();
        string p_status = Request["p_status"].ToString();


        string TemplateFile = "rpt_working_time_total_new.xls";
        string TempFile = "../../../system/temp/rpt_working_time_total_new_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;


        string SQL
   = " SELECT to_char(sysdate,'dd/mm/yyyy'),FIN.ORG_NM,FIN.WGROUP_NM,FIN.EMP_ID " +
       "                ,FIN.FULL_NAME " +
       "                ,TO_CHAR(TO_DATE(FIN.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
       "                ,FIN.WT " +
       " ,NULLIF(FIN.OT,0),NULLIF(FIN.NT,0),NULLIF(FIN.NT2,0),NULLIF(FIN.NT3,0),NULLIF(FIN.HT,0) "+
       "         ,NULLIF(FIN.WT_OT,0),NULLIF(FIN.OT_HT,0),NULLIF(FIN.N_OT,0)    "+
       "        FROM( " +
       "              SELECT C.ORG_NM AS ORG_NM,B.WORKGROUP_NM AS WGROUP_NM,A.EMP_ID AS EMP_ID,A.JOIN_DT AS JOIN_DT " +
       "            ,A.FULL_NAME AS FULL_NAME,NVL(TM.WT,0) AS WT " +
       "            ,NVL(OVT.OT,0) AS OT " +
       "            ,NVL(OVT.NT,0) AS NT " +
       "            ,NVL(OVT.NT2,0) AS NT2 " +
       "            ,NVL(OVT.HT,0) AS HT " +
       "            ,NVL(TM.WT,0) + NVL(OVT.OT,0) AS WT_OT " +
       "            ,NVL(OVT.OT,0)+NVL(OVT.HT,0) AS OT_HT " +
       "            ,A.TCO_ORG_PK AS TCO_ORG_PK " +
       "            FROM THR_EMPLOYEE A,THR_WORK_GROUP B,tco_ORG C " +
       "            ,(SELECT F.PK AS EMP_PK " +
       "                    ,SUM(NVL(M.WORK_TIME,0)) AS WT " +
       "                    FROM THR_TIME_MACHINE M,THR_EMPLOYEE F " +
       "                    WHERE M.DEL_IF=0 AND F.DEL_IF=0 AND F.PK=M.THR_EMP_PK " +
       "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',f.nation) =  '" + p_nation + "'" +
       "            AND DECODE('" + p_status + "' ,'ALL', '" + p_status + "',f.status) =  '" + p_status + "'" +
       "                    AND M.WORK_DT BETWEEN '" + p_from + "' AND '" + p_to + "' ";
        SQL = SQL + "                   AND (    F.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('" + p_tco_org_pk + "', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '" + p_tco_org_pk + "' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '" + p_tco_org_pk + "' = 'ALL') " +
        "                        AND (DECODE('" + p_search + "' ,'1',UPPER(F.EMP_ID),'2',F.ID_NUM,'3',UPPER(F.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "' ) " +
        "                            OR '" + p_input + "'  IS NULL) " +
        "                    GROUP BY F.PK           " +
        "                 ) TM    " +
        "                ,(SELECT F.PK AS EMP_PK " +
        "                    ,SUM(DECODE(E.OT_TYPE,'OT',NVL(E.OT_TIME,0),0)) AS OT " +
        "                    ,SUM(DECODE(E.OT_TYPE,'NT',NVL(E.OT_TIME,0),0)) AS NT " +
        "                    ,SUM(DECODE(E.OT_TYPE,'NT2',NVL(E.OT_TIME,0),0)) AS NT2 " +
        "                    ,SUM(DECODE(E.OT_TYPE,'HT',NVL(E.OT_TIME,0),0)) AS HT " +
        "                    FROM THR_EXTRA_TIME E,THR_EMPLOYEE F " +
        "                    WHERE E.DEL_IF=0 AND F.DEL_IF=0 AND F.PK=E.THR_EMP_PK " +
                "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',f.nation) =  '" + p_nation + "'" +
                "            AND DECODE('" + p_status + "' ,'ALL', '" + p_status + "',f.status) =  '" + p_status + "'" +
        "                    AND E.WORK_DT BETWEEN '" + p_from + "' AND '" + p_to + "' ";
        SQL = SQL + "                   AND (    F.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('" + p_tco_org_pk + "', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '" + p_tco_org_pk + "' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '" + p_tco_org_pk + "' = 'ALL') " +
        "                        AND (DECODE('" + p_search + "' ,'1',UPPER(F.EMP_ID),'2',F.ID_NUM,'3',UPPER(F.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "' ) " +
        "                            OR '" + p_input + "'  IS NULL) " +
        "                    GROUP BY F.PK           " +
        "                 ) OVT    " +
        "            WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0  " +
        "            AND A.THR_WG_PK=B.PK AND A.TCO_ORG_PK=C.PK " +
        "            AND A.PK=OVT.EMP_PK(+)  " +
        "            AND A.PK=TM.EMP_PK(+)   " +
        "            AND A.JOIN_DT <= '" + p_to + "' " +
        "            AND (A.LEFT_DT>= '" + p_from + "'  OR A.LEFT_DT IS NULL)           " +
        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',a.nation) =  '" + p_nation + "'" +
        "            AND DECODE('" + p_status + "' ,'ALL', '" + p_status + "',a.status) =  '" + p_status + "'" +
        "            AND DECODE('" + p_wg + "' ,'ALL','" + p_wg + "' ,B.PK) = '" + p_wg + "' ";
        SQL = SQL + "                   AND (    A.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('" + p_tco_org_pk + "', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '" + p_tco_org_pk + "' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '" + p_tco_org_pk + "' = 'ALL') " +
        "            AND (DECODE('" + p_search + "' ,'1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "' ) " +
        "                        OR '" + p_input + "'  IS NULL) " +
        "            )FIN " +
        "            WHERE ( '" + p_val + "' = '=' and DECODE('" + p_opt + "','1',FIN.WT,'2',FIN.OT,'3',FIN.HT,'4',FIN.WT_OT,'5',FIN.OT_HT)=NVL('" + p_wt_ot + "',0) " +
        "                        or '" + p_val + "' = '>' and DECODE('" + p_opt + "','1',FIN.WT,'2',FIN.OT,'3',FIN.HT,'4',FIN.WT_OT,'5',FIN.OT_HT)>NVL('" + p_wt_ot + "',0) " +
        "                        or '" + p_val + "' = '<' and DECODE('" + p_opt + "','1',FIN.WT,'2',FIN.OT,'3',FIN.HT,'4',FIN.WT_OT,'5',FIN.OT_HT)<NVL('" + p_wt_ot + "',0) " +
        "                        or '" + p_val + "' = '>=' and DECODE('" + p_opt + "','1',FIN.WT,'2',FIN.OT,'3',FIN.HT,'4',FIN.WT_OT,'5',FIN.OT_HT)>=NVL('" + p_wt_ot + "',0) " +
        "                        or '" + p_val + "' = '<=' and DECODE('" + p_opt + "','1',FIN.WT,'2',FIN.OT,'3',FIN.HT,'4',FIN.WT_OT,'5',FIN.OT_HT)<=NVL('" + p_wt_ot + "',0) " +
        "                        OR NVL('" + p_wt_ot + "',0)=0) " +
        "            ORDER BY FIN.ORG_NM,FIN.WGROUP_NM,FIN.EMP_ID ";


        //----------------------------------

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


        exSheet.Cells[1, 1].Value = "WORKING TIME SUMMARY";
        exSheet.Cells[2, 2].Value = "Reporter ";        
        exSheet.Cells[2, 3].Value = p_user;
        exSheet.Cells[3, 2].Value = "Report Date";
        exSheet.Cells[3, 3].Value = dt_total.Rows[0][0].ToString();
       
        exSheet.Cells[3, 6].Value = "Work Date";
        exSheet.Cells[3, 7].Value = p_from.Substring(6, 2) + "/" + p_from.Substring(4, 2) + "/" + p_from.Substring(0, 4);
        exSheet.Cells[3, 8].Value = "~";
        exSheet.Cells[3, 9].Value = p_to.Substring(6, 2) + "/" + p_to.Substring(4, 2) + "/" + p_to.Substring(0, 4);
        

        int i;
        int row_pos = 8;

        //insert row
        
        for (i = 0; i < irow-1 ; i++)
        {

            exSheet.Range[row_pos + i, 1].Rows.EntireRow.Insert();
        }
       // exSheet.Range[row_pos, 1, row_pos , 13].Borders[XlBordersIndex.xlEdgeTop].LineStyle = XlLineStyle.xlContinuous;
        //exSheet.Range[row_pos + irow-1, 1, row_pos + irow-1, 13].Borders[XlBordersIndex.xlEdgeTop].LineStyle = XlLineStyle.xlContinuous;

        //show data
        row_pos = 7;
        for (i = 0; i < irow; i++)
        {
            exSheet.Cells[row_pos + i, 1].Value = i + 1;
            for (int j = 1; j < icol ; j++)
            {                
                if (IsNumeric(dt_total.Rows[i][j].ToString()))
                {
                    exSheet.Cells[row_pos + i, j + 1].Value = Double.Parse(dt_total.Rows[i][j].ToString()); 
                }
                else
                {
                    exSheet.Cells[row_pos + i, j + 1].Value = dt_total.Rows[i][j].ToString();
                }                
            }
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

    public static bool IsNumeric(string strNum)
    {
        try
        {
            double tmp = double.Parse(strNum);
            return true;
        }
        catch
        {
            return false;
        }
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