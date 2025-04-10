defmodule FirstprojectWeb.Audio do
  use FirstprojectWeb, :live_view
  import Phoenix.HTML.Form
  import Phoenix.Component

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("go_to_" <> action, _params, socket) do
    {:noreply, assign(socket, :live_action, String.to_atom(action))}
  end

  def handle_event("go_back", _params, socket) do
    {:noreply, assign(socket, :live_action, :default)}
  end

  def render(assigns) do
    ~H"""
    <div class="relative h-screen bg-[#061131] overflow-hidden">
      <!-- Background Image Section -->
      <div class="absolute inset-0 z-0 opacity-100" style={
        cond do
          @live_action == :bedtime ->
            "background-image: url('https://s3-alpha-sig.figma.com/img/94a4/02f7/f4438ed4c6602d708526cdb2a1658bc9?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=lKghdhx6ggjz8cLVzT0iX9vy0oQZGQWswXkeyJOcFtKZlI9jbBVbvhhC1-dil0B9mgIY4z9Ixr0eZsSJ6cb0Pq-Vp-GQpyM-6slHAUMKztbUSeWJKkGrDS26meLTHkpKmoiSgFTuN6GELKbb2z3p~Szn~LSvj8k4mYj~rX-2~pMHpQHh-78L-iULFaUmdb~Oj1YvYk2a~Nbvm6vkHEtHam~TkVU5M94PDNErCn1IFrIE2XSiMjeSkVCJTqq0~e-MqJlGcNPCKoeS0ogk~xLDJLHmi09nDZu2iau4TcdChQjwmIn5Nv6GfhSPRAhzrPBzzbgRlo1jMCWf-oFrUiragw__')"
          
          @live_action == :radio ->
            "background-image: url('https://s3-alpha-sig.figma.com/img/592f/734b/6030d1aac9397acf6c65a23a2029b634?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=ghN90W924yj2vpqGgo87S3RzfofrdCBkrPlsaNhF2cvP9PWaLaL-Qd1Xm2Zqx3PSNHzdmzv-FjBVdgdSOyQFqWW4ejwFdMwC4cQp3VjaSDjaz7nsQnRYzrRxQuN5pSkcuP9rmTGP22x6hsQABWk0xIr0TCtErmGsA8atrv1qW4yvndrTHKHvnUQ8lRDcyUYwyKCfjrrPWYfQfxqVDrOAvi44rZxnfJU4f6Fo00Bg-vWh9cm1XISVnNLjR3ODJ~874g0R~RsHT497NCZw13xhTVW3NIv-OKsFE~HgB10ixLQ5bBS-tOa3Pl0ZhI~UCQhoWNcxzIFaxLc91kuTj42dvA__')"
          
          true ->
            "background-image: url('https://s3-alpha-sig.figma.com/img/9b9c/fb96/10010623cb07ef3170592f27dcf6bcc1?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=VKu8toPVdj-e86sPRNLUxRqhxA1sViuDtocUYPXV86cwQzGVZ9w7Sx5IuseA8klpYlWtjc9~tlZ3TrA7Cbs2wRlIK2ix288lR6Q4lijWQSBhAhV1uzm4LNcZKCrq0mrVtoziIv1yUXhu6TIrueuyh6qdda~4qrP8aX05u8w5OZJs8hv098tYQOMoZxnLSJmBCVknGkdSl4K~~t46zOURZfOKCI37EpbG4FPLIADJSZzBpmEdRvg-dKanUycDAPQyG8QgUCQnfx4u61-o6ZjoomZfgIcJtc5TQ8q~jcldwxHIb8NoOsGZC5tI4kXe1N5-VMVE2lCgREwztFQm3KrCnQ_')"
        end
      }></div>

      <!-- Main Content -->
      <div class="relative flex flex-col h-screen overflow-hidden">
        <!-- Button Section -->
        <div class="relative w-full p-4 flex items-center">
          <div class="relative transform transition-transform duration-150 active:scale-90 cursor-pointer">
            <svg width="48" height="48" viewBox="0 0 60 60" xmlns="http://www.w3.org/2000/svg" class="rounded-full">
              <defs>
                <radialGradient id="grad" cx="55%" cy="55%" r="50%">
                  <stop offset="0%" stop-color="#FDFDFD" />
                  <stop offset="45%" stop-color="#E4D0A8" />
                  <stop offset="100%" stop-color="#C28D47" />
                </radialGradient>
              </defs>
              <circle cx="30" cy="30" r="30" fill="url(#grad)" />
            </svg>
            <div class="w-8 h-8 font-bold absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 text-black cursor-pointer" phx-click="go_back">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-black" viewBox="0 0 24 24" fill="currentColor">
                <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/>
              </svg>
            </div>
          </div>
        </div>

        <!-- Content Section -->
        <div class="flex flex-1 overflow-hidden">
          <!-- Left Side -->
          <%= if @live_action == :bedtime do %>
            <div class="w-1/2 p-8 pt-0 flex justify-center">
              <span class="text-white text-5xl font-karma font-medium rounded-md">BEDTIME <br><span class="pl-2">STORIES</span></span>
            </div>
          <% end %>

          <%= if @live_action == :radio do %>
            <div class="w-1/2 p-8 pt-0 flex justify-center">
              <span class="text-white text-5xl font-karma font-medium rounded-md">ISLAMIC <br><span class="pl-5">RADIO</span></span>
            </div>
          <% end %>

          <%= if @live_action not in [:bedtime, :radio] do %>
            <div class="w-1/2 p-8 pl-7 flex justify-center">
              <!-- Empty when not in specific views -->
            </div>
          <% end %>

          <!-- Right Side Content -->
          <div class="relative z-10 flex items-center justify-center w-1/2">
            <div class="w-full h-full p-4 pt-0 flex overflow-y-auto justify-center">
              <%= if @live_action in [:bedtime, :radio] do %>
                <div class="flex flex-wrap gap-4">
                  <%= for item <- [
                    %{id: "mufti_menk", title_top: "ADAM (AS)", title_bottom: "PART 1"},
                    %{id: "prophets", title_top: "ADAM (AS) ", title_bottom: "PART 2"},
                    %{id: "adkhars", title_top: "NUH (AS)", title_bottom: "‎ "},
                    %{id: "radio", title_top: "IBRAHIM (AS)", title_bottom: "‎ "},
                    %{id: "bedtime", title_top: "MUSA (AS)", title_bottom: "‎ "},
                    %{id: "seerah", title_top: "LEGEND", title_bottom: "‎ "}
                  ] do %>
                    <div class="flex flex-col bg-white w-[234px] min-w-[234px]" phx-click={"go_to_#{item.id}"}>
                      <div class="relative w-[234px] min-w-[234px]">
                        <img src="https://s3-alpha-sig.figma.com/img/9f3f/c207/087e40ada70f3e0bed0f93ad0ae7f4b0?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=aK4O~aBtozxpk8I5m5iPXYthTCdawGcvenPIYS1iP6fO1uKlM8tqabstP4TN78h6XePk2ncPftTsN-ntpzxAU-bIO-DDulW7El-wTM-W69VA3722u2StIhtH1FpeS5l62uZf2zIEhC6xzKaCSLpOJCAO1pgmAHILsYYPsmPJ3tG-orH96MVMcVsTiKKqZAMA0zjEUfb6ocE9eDO5lAfxCDHo~5U5v2pv9jJ2IR1PKCfzU-WYQwNMjBFLPh3aYDHfDcJczSFYzpn7ne2y3y0RCOsCRrLis5BjFe3SR3qS8g1D1ndSupheSadsSf2qnwspPvjifkw-AqkjD58htPO6vg__" class="w-[234px] min-w-[234px]" />
                        <span class="absolute bottom-0 font-karma text-2xl left-0 right-0 text-center font-medium">
                          <%= if @live_action == :radio do %>
                            <!-- Custom radio station names -->
                            <span class="text-[#000000]">
                              <%= case item.id do %>
                                <% "seerah" -> %>PALESTINE <br>RADIO
                                <% "mufti_menk" -> %>PAKISTAN<br> RADIO
                                <% "prophets" -> %>ISLAMIC RADIO CHINA
                                <% "adkhars" -> %>TURKISH<br> RADIO
                                <% "radio" -> %>USA<br>RADIO
                                <% "bedtime" -> %>AFRICA <br>RADIO
                              <% end %>
                            </span>
                            <br/>
                            <span class="text-black"></span>
                          <% else %>
                            <!-- Original text for bedtime stories -->
                            <span class="text-[#9B7925]"><%= item.title_top %></span><br />
                            <span class="text-[#9B7925]"><%= item.title_bottom %></span>
                          <% end %>
                        </span>
                      </div>
                    </div>
                  <% end %>
                </div>
              <% else %>
                <button class="!text-7xl !leading-[5rem] font-medium rounded-lg text-white font-karma">
                  Audio <br>Library
                </button>
              <% end %>
            </div>
          </div>
        </div>

        <!-- Footer (hidden in detail views) -->
        <%= if @live_action not in [:bedtime, :radio] do %>
          <div class="relative z-20 p-2">
            <div class="flex overflow-x-auto gap-4 pb-4">
              <%= for item <- [
                %{id: "mufti_menk", title_top: "LECTURES BY", title_bottom: "MUFTI MENK"},
                %{id: "prophets", title_top: "STORIES OF", title_bottom: "PROPHETS"},
                %{id: "adkhars", title_top: "DAILY", title_bottom: "ADKHARS"},
                %{id: "radio", title_top: "ISLAMIC", title_bottom: "RADIO"},
                %{id: "bedtime", title_top: "BEDTIME", title_bottom: "STORIES"},
                %{id: "seerah", title_top: "SEERAH", title_bottom: "LECTURES"}
              ] do %>
                <div class="flex flex-col bg-white w-[234px] min-w-[234px]" phx-click={"go_to_#{item.id}"}>
                  <div class="relative w-[234px] min-w-[234px]">
                    <img src="https://s3-alpha-sig.figma.com/img/9f3f/c207/087e40ada70f3e0bed0f93ad0ae7f4b0?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=aK4O~aBtozxpk8I5m5iPXYthTCdawGcvenPIYS1iP6fO1uKlM8tqabstP4TN78h6XePk2ncPftTsN-ntpzxAU-bIO-DDulW7El-wTM-W69VA3722u2StIhtH1FpeS5l62uZf2zIEhC6xzKaCSLpOJCAO1pgmAHILsYYPsmPJ3tG-orH96MVMcVsTiKKqZAMA0zjEUfb6ocE9eDO5lAfxCDHo~5U5v2pv9jJ2IR1PKCfzU-WYQwNMjBFLPh3aYDHfDcJczSFYzpn7ne2y3y0RCOsCRrLis5BjFe3SR3qS8g1D1ndSupheSadsSf2qnwspPvjifkw-AqkjD58htPO6vg__" class="w-[234px] min-w-[234px]" />
                    <span class="absolute bottom-0 font-karma text-2xl left-0 right-0 text-center font-medium">
                      <span class="text-[#9B7925]"><%= item.title_top %></span><br />
                      <span class="text-black"><%= item.title_bottom %></span>
                    </span>
                  </div>
                </div>
              <% end %>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
