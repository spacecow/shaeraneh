# -*- coding: utf-8 -*-
require 'spec_helper'

describe Poem do
  describe "#set_initials" do
    it "updates the initial value" do
      poem = Factory(:poem)
      poem.verses << create_verse("ألا یا أیها السّاقی! أدر کأساً وناوِلها!")
      poem.update_attribute(:initial,"")
      Poem.last.initial.should be_blank
      Poem.set_initials
      Poem.last.initial.should eq "ا"
    end
  end

  describe "#after_add, persian" do
    before(:each) do
      @poem = Factory(:poem)
    end

    it "ا as initial for ا" do
      @poem.verses << create_verse("ألا یا أیها السّاقی! أدر کأساً وناوِلها!")
      @poem.initial.should eq "ا"
    end

    context "ب ت ث as initial for" do
      it "ب" do
        @poem.verses << create_verse("گفتم: «ای سلطان خوبان رحم کن بر این غریب»")
      end
      it "ت" do
        @poem.verses << create_verse("آن پیکِ نامَور که رسید از دیار دوست")
      end
      it "ث" do
        @poem.verses << create_verse("درد ما را نیست درمان الغیاث!")
      end
      after(:each) do
        @poem.initial.should eq "ب ت ث"
      end
    end

    context "ج ح خ as initial for" do
      it "ج" do
        @poem.verses << create_verse("تویی که بر سر خوبان کشوری چون تاج")
      end
      it "ح" do
        @poem.verses << create_verse("اگر به مذهب تو خون عاشق است مباح")
      end
      it "خ" do
        @poem.verses << create_verse("دل من در هوای روی فرخ")
      end
      after(:each) do
        @poem.initial.should eq "ج ح خ"
      end
    end

    it "د as initial for د" do
      @poem.verses << create_verse("آن کس که به دست جام دارد")
      @poem.initial.should eq "د"
    end

    context "ر ز as initial for" do
      it "ر" do
        @poem.verses << create_verse("الا ای طوطی گویای اسرار")
      end
      it "ز" do
        @poem.verses << create_verse("ای سرو ناز حسن که خوش می‌روی به ناز")
      end
      after(:each) do
        @poem.initial.should eq "ر ز"
      end
    end

    context "س ش as initial for" do
      it "س" do
        @poem.verses << create_verse("ای صبا گر بگذری بر ساحل رود ارس")
      end
      it "ش" do
        @poem.verses << create_verse("اگر رفیق شفیقی درست پیمان باش")
      end
      after(:each) do
        @poem.initial.should eq "س ش"
      end
    end

    context "ع غ as initial for" do
      it "ع" do
        @poem.verses << create_verse("بامدادان که ز خلوتگه کاخ ابداع")
      end
      it "غ" do
        @poem.verses << create_verse("سحر به بوی گلستان دمی شدم در باغ")
      end
      after(:each) do
        @poem.initial.should eq "ع غ"
      end
    end

    context "ف ق as initial for" do
      it "ف" do
        @poem.verses << create_verse("طالع اگر مدد دهد، دامنش آورم به کف")
      end
      it "ق" do
        @poem.verses << create_verse("زبان خامه ندارد سر بیان فراق")
      end
      after(:each) do
        @poem.initial.should eq "ف ق"
      end
    end

    it "ک as initial for ک" do
      @poem.verses << create_verse("اگر شراب خوری جرعه‌ای فشان بر خاک")
      @poem.initial.should eq "ک"
    end

    it "ل as initial for ل" do
      @poem.verses << create_verse("اگر به کوی تو باشد مرا مجال وصول")
      @poem.initial.should eq "ل"
    end

    it "م as initial for م" do
      @poem.verses << create_verse("آن که پامال جفا کرد چو خاک راهم")
      @poem.initial.should eq "م"
    end

    it "ن as initial for ن" do
      @poem.verses << create_verse("احمد الله علی معدله السلطان")
      @poem.initial.should eq "ن"
    end

    it "ه as initial for ه" do
      @poem.verses << create_verse("از خون دل نوشتم نزدیک دوست نامه")
      @poem.initial.should eq "ه"
    end

    it "و as initial for و" do
      @poem.verses << create_verse("ای آفتاب آینه دار جمال تو")
      @poem.initial.should eq "و"
    end

    it "ی as initial for ی" do
      @poem.verses << create_verse("آن غالیه‌خط گر سوی ما نامه نوشتی")
      @poem.initial.should eq "ی"
    end
  end

  describe "#after_add" do
    before(:each) do
      @poem = Factory(:poem)
      @poem.verses << create_verse("1st")
    end

    it "caches verse content in poetry" do
    end

    it "caches only the first verse content" do
      @poem.verses << create_verse("2nd")
    end

    after(:each) do
      @poem.first_verse.should eq "1st"     
      @poem.initial.should eq "t"
    end
  end

  describe "#after_remove" do
    before(:each) do
      @poem = Factory(:poem)
      @verse = create_verse("1st")
      @poem.verses << @verse
    end

    it "removes cached verse when no verses are left" do
      @poem.verses.destroy(@verse)
      @poem.first_verse.should eq "" 
      @poem.initial.should eq "" 
    end

    it "does not remove cached verse if there are other verses" do
      verse2 = create_verse("2nd")
      @poem.verses << verse2
      @poem.verses.destroy(verse2)
      @poem.first_verse.should eq "1st"
      @poem.initial.should eq "t"
    end

    it "changes the cached verse if the first verse is deleted" do
      verse2 = create_verse("2nd")
      @poem.verses << verse2
      @poem.verses.destroy(@verse)
      @poem.first_verse.should eq "2nd"
      @poem.initial.should eq "d"
    end
  end
end
