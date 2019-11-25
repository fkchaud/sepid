class BackupController < ApplicationController
  def admin_backup
    @files = Dir.glob("app/backup/*")
    @dates = []
    (0...@files.length).each do |i|
      @files[i] = @files[i].sub "app/backup/", ""
    end
    @files.each do |file|
      @dates << File.ctime(".\\app\\backup\\#{file}")
    end
  end

  def make_backup
    pid = spawn(".\\app\\services\\Backup.bat")
    Process.detach(pid)
    flash[:success] = "Backup en proceso, cuando finalice aparecerá en el listado"
    redirect_to admin_backup_path
  end

  def recover_backup
    pid = spawn(".\\app\\services\\Recover.bat #{params[:user][:file]}")
    Process.detach(pid)
    flash[:success] = "Recuperación en proceso, puede tomar unos minutos"
    redirect_to admin_backup_path
  end
end
