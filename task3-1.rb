#csvライブラリの読み込み
require "csv"

#動作を番号で入力
puts "半角で1(新規でメモを作成) or 2(既存のメモ編集する)を入力し、Enterを押してください。"
memo_type = gets.chomp

#入力した番号に応じてifで条件分岐
#1の場合
if memo_type == "1"
  #ファイル名を入力
  puts "新規メモのファイル名を拡張子を除いて入力し、Enterを押してください。"
  file_title = gets.chomp
  
  #メモの内容を入力
  puts "メモしたい内容を入力してください。"
  puts "完了したらEnterを押し、その後にCtrl + Dを押してください。"
  memo_content = STDIN.read.chomp
  
  #csvとして書き出し
  CSV.open("#{file_title}.csv", "w") do |csv|
    csv << [memo_content]
  end
  
  #完了メッセージ
  puts "メモの作成が完了しました。"

#2の場合
elsif memo_type == "2"
  #ファイル名を入力
  puts "既存メモのファイル名を拡張子を除いて入力し、Enterを押してください。"
  file_title = gets.chomp
  
  begin
  #既存メモの内容を表示
  existing_file = File.open("#{file_title}.csv")
  existing_memo = existing_file.read
  existing_file.close
  puts "現在そのメモには以下のテキストが入力されています。"
  puts existing_memo
  
  #編集内容を入力
  puts "追記する内容を入力してください。"
  puts "完了したらEnterを押し、その後にCtrl + Dを押してください。"
  memo_content = STDIN.read.chomp

  #csvとして書き出し
  CSV.open("#{file_title}.csv", "a") do |csv|
    csv << [memo_content]
  end
  
  #完了メッセージ
  puts "メモの追記が完了しました。"
  
  #入力したファイル名のファイルがなければやり直し
  rescue
    puts "入力したファイル名のファイルは存在しません。"
    puts "最初からやり直してください。"
  end
  
#1と2以外の場合
else
  puts "最初からやり直してください。"
end