package com.sample.service;

import com.mongodb.gridfs.GridFSDBFile;

import java.io.InputStream;

public interface StorageService {
    String save(InputStream inputStream, String contentType, String filename);

    GridFSDBFile get(String id);

    GridFSDBFile getByFilename(String filename);
}
