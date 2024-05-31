require 'rails_helper'

RSpec.describe Profile, type: :model do
  before(:all) do
    @user = create(:user)
    @profile = @user.profile
  end

  it "is valid with valid attributes" do
    expect(@profile).to be_valid
  end

  it "is not valid with too long of a name" do
    @profile.update(name: 'osidfjosdifjsoidjfosdijfosdijfosdijfsodijfosidjfosidjfoisdjfosdijfosdijfosdijfosdijfodisfj', bio: "hey there")
    expect(@profile).to_not be_valid
  end

  it "is not valid with too long of a bio" do
    @profile.update(name: 'normalguy', bio: "Hey there! I'm alex, a brooklynite through and through. You'll find me navigating the bustling streets of nyc, capturing fleeting moments with my camera.

    Photography is my jam—from sunsets over the williamsburg bridge to the graffiti-clad walls of bushwick. I'm all about finding beauty in the everyday. And yes, i still shoot film because digital feels too clinical.
    
    When i'm not behind the lens, i'm grooving to tunes. My spotify playlist spans genres: indie rock, jazz fusion, and the occasional guilty pleasure (hello, '90s boy bands). Air guitar? Nailed it.")
    expect(@profile).to_not be_valid
  end
end
