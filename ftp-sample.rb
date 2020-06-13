require 'openssl'
require 'double_bag_ftps'
require 'fileutils'

DoubleBagFTPS.open('localhost', 'ftps', 'pass', nil, DoubleBagFTPS::IMPLICIT, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |ftps|
  ftps.passive = true
  ftps.debug_mode = true

  # 作業dir作成
  work_dir = "dir_test_#{Date.current.strftime('%H%M%S')}"
  ftps.mkdir("./remote/#{work_dir}")
  ftps.chdir("./remote/#{work_dir}")
  puts "SMBCにFTPSで接続しました。localhost:10211:ftps:pass"

  list = ftps.nlst
  puts list

  # ftps.nlst("-F R_M_#{code}").first
  # puts "SMBCにFTPSで接続しました。localhost:10211:ftps:pass"

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
  ftps.delete(file)
  puts "SMBCにFTPSで接続しました。localhost:10211:ftps:pass"
end

