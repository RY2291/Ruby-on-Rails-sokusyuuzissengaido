require "rails_helper"

describe "タスク管理機能" do
  let(:user_a) { FactoryBot.create(:user, name: "ユーザーA", email: "a@test.com") }
  let(:user_b) { FactoryBot.create(:user, name: "ユーザーB", email: "b@test.com") }
  let(:task_a) { FactoryBot.create(:task, name: "最初のタスク", user: user_a) }
  
  before do
    FactoryBot.create(:task, name: "最初のタスク", user: user_a)
    visit login_path
    fill_in "メールアドレス", with: login_user.email
    fill_in "パスワード", with: login_user.password
    click_button "ログインする"
  end

  shared_examples_for "ユーザーAが作成したタスクが表示される" do
    it { expect(page).to have_content "最初のタスク"}
  end

  describe "一覧表示機能" do
    context "ユーザーAがログインしている時" do
      let(:login_user) { user_a }

      it_behaves_like "ユーザーAが作成したタスクが表示される"
    end

    context "ユーザーBがログインしている時" do
      let(:login_user) { user_b }

      it "ユーザーAが作成したタスクが表示されない" do
        expect(page).to have_no_content "最初のタスク"
      end
    end
  end

  describe "詳細表示機能" do
    context "ユーザーAがログインしている時" do
      let(:login_user) { user_a }

      before do
        visit tasks_path(task_a)
      end

      it_behaves_like "ユーザーAが作成したタスクが表示される"
    end
  end

  describe "新規作成の機能" do
    let(:login_user) { user_a }
    let(:task_name) { "新規作成のテストを書く"}

    before do
      visit new_task_path
      fill_in "名称", with: task_name
      click_button "登録する"
    end

    context "新規作成画面で名称を入力した時" do

      it "入力が成功した時" do
        expect(page).to have_selector ".alert-sucess", text: "新規作成のテストを書く"
      end
    end

    context "新規作成画面で名称を入力しなかった時" do
      let(:task_name) { '' }

      it "エラーになる" do
        within "#text" do
          expect(page).to have_content "名称を入力してください"
        end
      end
    end
  end
end