package com.ese.mappers.manage.download;

import java.util.List;

import com.ese.vo.notice.DownloadNotice;
import com.ese.vo.notice.FileAttach;

public interface UploadMapper {

	List<DownloadNotice> getAllUpload();
	int getUploadSeq();
	int getFileNoSeq();
	void addUpload(DownloadNotice downloadNotice);
	void addFile(FileAttach fileAttach);
	FileAttach getFileNoByName(String name);
	DownloadNotice getUploadByNo(int fileNo);
}
