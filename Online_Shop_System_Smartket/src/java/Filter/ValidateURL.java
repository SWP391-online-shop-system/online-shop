/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package Filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import jdk.nashorn.internal.ir.BreakNode;
import view.User;

/**
 *
 * @author admin
 */
public class ValidateURL implements Filter {

    private static final boolean debug = true;
    private FilterConfig filterConfig = null;

    public ValidateURL() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
        }
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
        }

    }

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        if (debug) {
        }
        doBeforeProcessing(request, response);
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();
        String url = req.getServletPath();

        if (url.endsWith(".jsp") && !url.contains("error404.jsp")) {
            res.sendRedirect("HomePageURL");
        } else {

            User a = (User) session.getAttribute("account");
            if (session.getAttribute("account") != null) {
                if ((a.getRoleID() == 2) || a.getRoleID() == 3 || a.getRoleID() == 4 || a.getRoleID() == 5) {
                    if (url.startsWith("/blog") || url.startsWith("/cblog") || url.startsWith("/searchblog") || url.startsWith("/ProductDetail") || url.startsWith("/HomePageURL") || url.startsWith("/CartURL") || url.startsWith("/ProductListURL") || url.startsWith("/contactURL")) {
                        res.sendRedirect("404");
                    }
                }
            }
            if (url.contains("loginURL") && a != null) {
                res.sendRedirect("HomePageURL");
            }
            if (session.getAttribute("account") != null) {
            if ((a.getRoleID() == 2 )|| a.getRoleID() == 3 || a.getRoleID() == 4 || a.getRoleID() == 5) {
                if (url.startsWith("/blog") || url.startsWith("/cblog") || url.startsWith("/searchblog") || url.startsWith("/ProductDetail") || url.startsWith("/HomePageURL") || url.startsWith("/CartURL") || url.startsWith("/ProductListURL") || url.startsWith("/contactURL")) {
                    res.sendRedirect("404");
                }
            }
            }

            if (url.startsWith("/marketing") || url.startsWith("/Marketing")) {
                if (session.getAttribute("account") == null) {
                    res.sendRedirect("loginURL");
                } else {
                    if (!(a.getRoleID() == 2)) {
                        res.sendRedirect("404");
                    }
                }
            }

            if (url.startsWith("/admin") || url.startsWith("/Admin")) {
                if (session.getAttribute("account") == null) {
                    res.sendRedirect("loginURL");
                } else {
                    if (!(a.getRoleID() == 5)) {
                        res.sendRedirect("404");
                    }
                }
            }
            if (url.startsWith("/sale")) {
                if (url.contains("saleOrderDetailURL") || url.contains("saleDashBoardURL")) {
                    if (session.getAttribute("account") == null) {
                        res.sendRedirect("loginURL");
                    } else if (a.getRoleID() != 3 && a.getRoleID() != 4) {
                        res.sendRedirect("404");
                    }
                } else {
                    if (session.getAttribute("account") == null) {
                        res.sendRedirect("loginURL");
                    } else if (url.contains("saleManager")) {
                        if (a.getRoleID() != 4) {
                            res.sendRedirect("404");
                        }
                    } else if (a.getRoleID() != 3) {
                        res.sendRedirect("404");
                    }
                }
            }
            Throwable problem = null;
            try {
                chain.doFilter(request, response);
            } catch (Throwable t) {
                problem = t;
                t.printStackTrace();
            }

            doAfterProcessing(request, response);
            if (problem != null) {
                if (problem instanceof ServletException) {
                    throw (ServletException) problem;
                }
                if (problem instanceof IOException) {
                    throw (IOException) problem;
                }
                sendProcessingError(problem, response);
            }
        }
    }

    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    @Override
    public void destroy() {
    }

    @Override
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("ValidateURL()");
        }
        StringBuffer sb = new StringBuffer("ValidateURL(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

    private boolean pathExists(String path) {
        Path filePath = Paths.get(path);
        return Files.exists(filePath);
    }
}
