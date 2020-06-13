require 'openssl'
require 'double_bag_ftps'
require 'fileutils'

DoubleBagFTPS.open('localhost', 'files', 'pass', nil, DoubleBagFTPS::IMPLICIT, { verify_mode: OpenSSL::SSL::VERIFY_NONE }) do |ftps|
  ftps.passive = true
  ftps.debug_mode = true

  list = ftps.nlst
  puts list
  
  # 作業dir作成
  work_dir = "dir_test_#{Time.now.strftime('%H%M%S')}"
  ftps.mkdir("./#{work_dir}")
  ftps.chdir("./#{work_dir}")
  puts "SMBCにFTPSで接続しました。localhost:10211:ftps:pass"

  list = ftps.nlst
  puts list

  # テスト用ファイル
  FileUtils.touch("touch.txt")

  ftps.putbinaryfile("touch.txt", "touch.txt", 4096)
  puts "送信"

  ftps.getbinaryfile("touch.txt", "receive_test.txt", 4096)
  puts "受信"

  list = Dir.glob("*")
  puts list

  list = ftps.nlst
  puts list

  # ファイル削除
  ftps.delete("touch.txt")
  puts "ファイルを削除しました"
end

