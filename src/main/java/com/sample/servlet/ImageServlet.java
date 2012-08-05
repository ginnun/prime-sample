package com.sample.servlet;

import com.mongodb.gridfs.GridFSDBFile;
import com.sample.service.StorageService;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ImageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        WebApplicationContext springContext =
                WebApplicationContextUtils.getWebApplicationContext(getServletContext());
        StorageService storageService = (StorageService) springContext.getBean("storageService");

        String[] fileSplit = req.getPathInfo().split("\\.");
        String fileId = fileSplit[0];
        fileId = fileId.substring(1);
        try {
            GridFSDBFile file = storageService.get(fileId);
            resp.setContentType("image/png");
            resp.setContentLength((int) file.getLength());
            file.writeTo(resp.getOutputStream());
            file.getInputStream().close();
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.getOutputStream().close();
        }
    }
}
