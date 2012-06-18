# -*- coding: utf-8 -*-
describe "Poems, index:" do
  context "member layout without poems" do
    before(:each){ visit poems_path } 

    it "has a title" do
      page.should have_title("Poems")
    end

    it "has no link to a new poem" do
      page.should_not have_link("New Poem")
    end

    it "has no bottom link to a new poem" do
      bottom_links.should_not have_link("New Poem")
    end

    it "has no top link to a new poem" do
      top_links.should_not have_link("New Poem")
    end

    it "has no poems div" do
      page.should_not have_div(:poemgroups)
    end    
  end

  context "member layout with poems" do
    before(:each) do
      create_poem('alpha')
      visit poems_path
    end

    it "has the poems within a div" do
      page.should have_div(:poemgroups)
    end    

    it "has a table for each initial letter" do
      div(:poemgroups).tables_no(:poemgroup).should be(1)
    end

    it "the initial letter is shown in the table header" do
      tableheader.should eq ['a']
    end

    it "the poem is shown in the table" do
      tablecell(0,0).should eq 'alpha'
    end

    it "has no edit link" do
      table(:poemgroup,0).should_not have_link('Edit')
    end

    it "has no delete link" do
      table(:poemgroup,0).should_not have_link('Del')
    end
  end

  context "sort poems" do
    it "" do
      create_poem("ألا یا أیها السّاقی! أدر کأساً وناوِلها!")
      create_poem("گفتم: «ای سلطان خوبان رحم کن بر این غریب»")
      create_poem("آن پیکِ نامَور که رسید از دیار دوست")
      create_poem("درد ما را نیست درمان الغیاث!")
      create_poem("تویی که بر سر خوبان کشوری چون تاج")
      create_poem("اگر به مذهب تو خون عاشق است مباح")
      create_poem("دل من در هوای روی فرخ")
      create_poem("آن کس که به دست جام دارد")
      create_poem("الا ای طوطی گویای اسرار")
      create_poem("ای سرو ناز حسن که خوش می‌روی به ناز")
      create_poem("ای صبا گر بگذری بر ساحل رود ارس")
      create_poem("اگر رفیق شفیقی درست پیمان باش")
      create_poem("بامدادان که ز خلوتگه کاخ ابداع")
      create_poem("سحر به بوی گلستان دمی شدم در باغ")
      create_poem("طالع اگر مدد دهد، دامنش آورم به کف")
      create_poem("زبان خامه ندارد سر بیان فراق")
      create_poem("اگر شراب خوری جرعه‌ای فشان بر خاک")
      create_poem("اگر به کوی تو باشد مرا مجال وصول")
      create_poem("آن که پامال جفا کرد چو خاک راهم")
      create_poem("احمد الله علی معدله السلطان")
      create_poem("ای آفتاب آینه دار جمال تو")
      create_poem("از خون دل نوشتم نزدیک دوست نامه")
      create_poem("آن غالیه‌خط گر سوی ما نامه نوشتی")
      visit poems_path
      tablecell(0,0,nil,0).should eq "ألا یا أیها السّاقی! أدر کأساً وناوِلها!"
      tablecell(0,0,nil,1).should eq "گفتم: «ای سلطان خوبان رحم کن بر این غریب»"
      tablecell(1,0,nil,1).should eq "آن پیکِ نامَور که رسید از دیار دوست"
      tablecell(2,0,nil,1).should eq "درد ما را نیست درمان الغیاث!"
      tablecell(0,0,nil,2).should eq "تویی که بر سر خوبان کشوری چون تاج"
      tablecell(1,0,nil,2).should eq "اگر به مذهب تو خون عاشق است مباح"
      tablecell(2,0,nil,2).should eq "دل من در هوای روی فرخ"
      tablecell(0,0,nil,3).should eq "آن کس که به دست جام دارد"
      tablecell(0,0,nil,4).should eq "الا ای طوطی گویای اسرار"
      tablecell(1,0,nil,4).should eq "ای سرو ناز حسن که خوش می‌روی به ناز"
      tablecell(0,0,nil,5).should eq "ای صبا گر بگذری بر ساحل رود ارس"
      tablecell(1,0,nil,5).should eq "اگر رفیق شفیقی درست پیمان باش"
      tablecell(0,0,nil,6).should eq "بامدادان که ز خلوتگه کاخ ابداع"
      tablecell(1,0,nil,6).should eq "سحر به بوی گلستان دمی شدم در باغ"
      tablecell(0,0,nil,7).should eq "طالع اگر مدد دهد، دامنش آورم به کف"
      tablecell(1,0,nil,7).should eq "زبان خامه ندارد سر بیان فراق"
      tablecell(0,0,nil,8).should eq "اگر به کوی تو باشد مرا مجال وصول"
      tablecell(0,0,nil,9).should eq "آن که پامال جفا کرد چو خاک راهم"
      tablecell(0,0,nil,10).should eq "احمد الله علی معدله السلطان"
      tablecell(0,0,nil,11).should eq "از خون دل نوشتم نزدیک دوست نامه"
      tablecell(0,0,nil,12).should eq "ای آفتاب آینه دار جمال تو"
      tablecell(0,0,nil,13).should eq "اگر شراب خوری جرعه‌ای فشان بر خاک"
      tablecell(0,0,nil,14).should eq "آن غالیه‌خط گر سوی ما نامه نوشتی"
    end
  end

  context "admin layout without poems" do
    before(:each) do
      login_admin
      visit poems_path
    end

    it "has a bottom link to a new poem" do
      bottom_links.should have_link("New Poem")
    end

    it "has a top link to a new poem" do
      top_links.should have_link("New Poem")
    end
  end

  context "admin layout without poems" do
    before(:each) do
      login_admin
      create_poem('alpha')
      visit poems_path
    end

    it "has an edit link" do
      table(:poemgroup,0).should have_link('Edit')
    end

    it "has a delete link" do
      table(:poemgroup,0).should have_link('Del')
    end
  end
end
