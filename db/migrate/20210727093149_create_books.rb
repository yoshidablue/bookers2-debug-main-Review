class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string  :title
      t.text    :body
      t.integer :user_id
      # string型は、整数（1、2）で行う場合。float型は、半分の星（0.5、1.5など）の評価を行う場合。
      t.float   :star

      t.timestamps
    end
  end
end
