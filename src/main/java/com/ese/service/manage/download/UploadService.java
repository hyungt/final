package com.ese.service.manage.download;

import java.util.List;

import com.ese.vo.notice.DownloadNotice;
import com.ese.vo.notice.FileAttach;

public interface UploadService {

	List<DownloadNotice> getAllUpload();
	int getUploadSeq();
	void addUpload(DownloadNotice downloadNotice);
	void addFile(FileAttach fileAttach);
	FileAttach getFileNoByName(String name);
	DownloadNotice getUploadByNo(int fileNo);
}
