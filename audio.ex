defmodule FirstprojectWeb.Audio do
  use FirstprojectWeb, :live_view
  import Phoenix.HTML.Form  
  import Phoenix.Component

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="relative h-screen bg-[#061131] overflow-hidden">
      <!-- Background Image -->
      <div class="absolute inset-0 z-0 opacity-100">
        <img src="https://s3-alpha-sig.figma.com/img/9b9c/fb96/10010623cb07ef3170592f27dcf6bcc1?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=a-u8nKROpVF4Ha4HM9UtXTNP1h7MLvIxSqQCVDPdp~8RYxUZqD41Y3GuKyXDooZkudvPiMnhl20D9DjnzwVe669F0juXGUxyh3R7KgEACs5dsAUd5DOmhid-gHTml~y8iH4P~OrmJ~QBhtnHBZADV7EvfBFvQ01ooRGHsGMi3t8ncnq6IaHmc3zKf~Kui76CbqBzwoW5qhAEjSN1AyJ1RCrHQsdcGPjNheYcFTJfviylqfGmaZ-Lp8~14s43YoaSYCUGpYhWI~D~Hw1jVH3US3SIjLeQ2hpcb6QseQszGWL1-UgvAgUxObCzJ-b2748Dr8lCbcbC1yoyfNysN0nX3A__"
          class="w-full h-full object-cover"
          alt="Audio background" />
      </div>

      <!-- Main Content -->
      <div class="relative flex flex-col h-screen overflow-hidden">
        <!-- Button Section -->
        <div class="w-full p-4 flex">
          <button class="w-12 h-12 rounded-full font-extrabold bg-gradient-to-b from-[#C28D47] to-brown-500 flex justify-center items-center shadow-lg">
            <.icon name="hero-arrow-left" class="w-8 h-8 text-black font-extrabold" />
          </button>
        </div>

        <!-- Content Section -->
        <div class="flex flex-1 overflow-hidden">
          <!-- Left Side -->
          <div class="w-1/2 p-8 flex items-center justify-center">
          </div>

          <!-- Right Side -->
          <div class="relative z-10 flex items-center justify-center w-1/2">
            <div class="w-full h-full p-4 flex justify-center">
              <button class="text-lg text-white rounded-lg">
                Audio Library
              </button>
            </div>
          </div>
        </div>
 
        <!-- Footer -->
        <div class="relative z-20 p-2">
          <div class="flex flex-wrap gap-4">
            <div class="flex flex-col text-center h-[207px] w-[234px] p-2 bg-white rounded-lg">
              <img src="https://s3-alpha-sig.figma.com/img/9f3f/c207/087e40ada70f3e0bed0f93ad0ae7f4b0?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=aK4O~aBtozxpk8I5m5iPXYthTCdawGcvenPIYS1iP6fO1uKlM8tqabstP4TN78h6XePk2ncPftTsN-ntpzxAU-bIO-DDulW7El-wTM-W69VA3722u2StIhtH1FpeS5l62uZf2zIEhC6xzKaCSLpOJCAO1pgmAHILsYYPsmPJ3tG-orH96MVMcVsTiKKqZAMA0zjEUfb6ocE9eDO5lAfxCDHo~5U5v2pv9jJ2IR1PKCfzU-WYQwNMjBFLPh3aYDHfDcJczSFYzpn7ne2y3y0RCOsCRrLis5BjFe3SR3qS8g1D1ndSupheSadsSf2qnwspPvjifkw-AqkjD58htPO6vg__" class="w-42 h-42  " />
              <span class="font-medium">Stories of Prophets</span>
            </div>
            <div class="flex flex-col text-center h-[207px] w-[234px] p-2 bg-white rounded-lg">
              <img src="https://s3-alpha-sig.figma.com/img/9f3f/c207/087e40ada70f3e0bed0f93ad0ae7f4b0?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=aK4O~aBtozxpk8I5m5iPXYthTCdawGcvenPIYS1iP6fO1uKlM8tqabstP4TN78h6XePk2ncPftTsN-ntpzxAU-bIO-DDulW7El-wTM-W69VA3722u2StIhtH1FpeS5l62uZf2zIEhC6xzKaCSLpOJCAO1pgmAHILsYYPsmPJ3tG-orH96MVMcVsTiKKqZAMA0zjEUfb6ocE9eDO5lAfxCDHo~5U5v2pv9jJ2IR1PKCfzU-WYQwNMjBFLPh3aYDHfDcJczSFYzpn7ne2y3y0RCOsCRrLis5BjFe3SR3qS8g1D1ndSupheSadsSf2qnwspPvjifkw-AqkjD58htPO6vg__" class="w-42 h-42 mx-auto " />
              <span class="font-medium">Daily Adkhars</span>
            </div>
            <div class="flex flex-col text-center h-[207px] w-[234px] p-2 bg-white rounded-lg">
              <img src="https://s3-alpha-sig.figma.com/img/9f3f/c207/087e40ada70f3e0bed0f93ad0ae7f4b0?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=aK4O~aBtozxpk8I5m5iPXYthTCdawGcvenPIYS1iP6fO1uKlM8tqabstP4TN78h6XePk2ncPftTsN-ntpzxAU-bIO-DDulW7El-wTM-W69VA3722u2StIhtH1FpeS5l62uZf2zIEhC6xzKaCSLpOJCAO1pgmAHILsYYPsmPJ3tG-orH96MVMcVsTiKKqZAMA0zjEUfb6ocE9eDO5lAfxCDHo~5U5v2pv9jJ2IR1PKCfzU-WYQwNMjBFLPh3aYDHfDcJczSFYzpn7ne2y3y0RCOsCRrLis5BjFe3SR3qS8g1D1ndSupheSadsSf2qnwspPvjifkw-AqkjD58htPO6vg__" class="w-42 h-42 mx-auto " />
              <span class="font-medium">Islamic Radio</span>
            </div>
          <div class="flex flex-col items-center p-2 bg-white rounded-lg w-[234px] min-w-[234px]">
  <!-- Image container with constrained dimensions -->
  <div class="w-36 h-44 flex items-center justify-center overflow-hidden">
    <img 
      src="https://s3-alpha-sig.figma.com/img/9f3f/c207/087e40ada70f3e0bed0f93ad0ae7f4b0?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=aK4O~aBtozxpk8I5m5iPXYthTCdawGcvenPIYS1iP6fO1uKlM8tqabstP4TN78h6XePk2ncPftTsN-ntpzxAU-bIO-DDulW7El-wTM-W69VA3722u2StIhtH1FpeS5l62uZf2zIEhC6xzKaCSLpOJCAO1pgmAHILsYYPsmPJ3tG-orH96MVMcVsTiKKqZAMA0zjEUfb6ocE9eDO5lAfxCDHo~5U5v2pv9jJ2IR1PKCfzU-WYQwNMjBFLPh3aYDHfDcJczSFYzpn7ne2y3y0RCOsCRrLis5BjFe3SR3qS8g1D1ndSupheSadsSf2qnwspPvjifkw-AqkjD58htPO6vg__" 
      
    />
  </div>
  <span class="font-medium ">Bedtime Stories</span>
</div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end