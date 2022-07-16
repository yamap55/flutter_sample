#https://github.com/matsp/docker-flutter/blob/master/stable/Dockerfile
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
RUN echo $TZ > /etc/timezone

# Or your actual UID, GID on Linux if not the default 1000
ENV USERNAME=vscode
ENV USER_UID=1000
ENV USER_GID=$USER_UID

# change default shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN chsh -s /bin/bash

# ENV JAVA_VERSION="8"
# ENV ANDROID_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip"
# ENV ANDROID_VERSION="29"
# ENV ANDROID_BUILD_TOOLS_VERSION="29.0.3"
# ENV ANDROID_ARCHITECTURE="x86_64"
# ENV ANDROID_SDK_ROOT="/home/$USER/android"
ENV FLUTTER_CHANNEL="stable"
ENV FLUTTER_VERSION="3.0.5"
ENV FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/$FLUTTER_CHANNEL/linux/flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz"
ENV FLUTTER_HOME="/home/$USERNAME/flutter"
# ENV FLUTTER_WEB_PORT="8090"
# ENV FLUTTER_DEBUG_PORT="42000"
# ENV FLUTTER_EMULATOR_NAME="flutter_emulator"
ENV PATH="$FLUTTER_HOME/bin:$FLUTTER_HOME/.pub-cache/bin:$PATH"

# TODO:
# ENV PATH="$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/platforms:$FLUTTER_HOME/bin:$PATH"

# Increase timeout for apt-get to 300 seconds
RUN /bin/echo -e "\n\
    Acquire::http::Timeout \"300\";\n\
    Acquire::ftp::Timeout \"300\";" >> /etc/apt/apt.conf.d/99timeout

# Configure apt and install packages
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install --yes --no-install-recommends sudo vim tzdata less wget curl unzip sed git bash xz-utils ca-certificates openjdk-8-jdk ssh-client \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# install hadolint
RUN wget --progress=dot:giga https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64 -O /usr/local/bin/hadolint \
    && chmod +x /usr/local/bin/hadolint

# RUN apt-get update \
#   && apt-get install --yes --no-install-recommends openjdk-$JAVA_VERSION-jdk curl unzip sed git bash xz-utils 
# TODO: libglvnd0 ssh xauth x11-xserver-utils libpulse0 libxcomposite1 libgl1-mesa-glx sudo \
#   && rm -rf /var/lib/{apt,dpkg,cache,log}

# Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # Add sudo support for non-root user
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

# # android sdk
# RUN mkdir -p $ANDROID_SDK_ROOT \
#   && mkdir -p /home/$USER/.android \
#   && touch /home/$USER/.android/repositories.cfg \
#   && curl -o android_tools.zip $ANDROID_TOOLS_URL \
#   && unzip -qq -d "$ANDROID_SDK_ROOT" android_tools.zip \
#   && rm android_tools.zip \
#   && mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/tools \
#   && mv $ANDROID_SDK_ROOT/cmdline-tools/bin $ANDROID_SDK_ROOT/cmdline-tools/tools \
#   && mv $ANDROID_SDK_ROOT/cmdline-tools/lib $ANDROID_SDK_ROOT/cmdline-tools/tools \
#   && yes "y" | sdkmanager "build-tools;$ANDROID_BUILD_TOOLS_VERSION" \
#   && yes "y" | sdkmanager "platforms;android-$ANDROID_VERSION" \
#   && yes "y" | sdkmanager "platform-tools" \
#   && yes "y" | sdkmanager "emulator" \
#   && yes "y" | sdkmanager "system-images;android-$ANDROID_VERSION;google_apis_playstore;$ANDROID_ARCHITECTURE"

# flutter
RUN wget --progress=dot:giga $FLUTTER_URL -O flutter.tar.xz  \
    && mkdir -p $FLUTTER_HOME \
    && tar xf flutter.tar.xz -C /home/$USERNAME \
    && rm flutter.tar.xz \
    && flutter config --no-analytics --enable-web \
    && flutter precache \
    #   && yes "y" | flutter doctor --android-licenses \
    && flutter doctor \
    #   && flutter emulators --create \
    && flutter update-packages
# && flutter pub global activate fvm
# && fvm install \
# && fvm flutter pub get

# RUN  fvm install \
#     && fvm flutter pub get

# COPY entrypoint.sh /usr/local/bin/
# COPY chown.sh /usr/local/bin/
# COPY flutter-android-emulator.sh /usr/local/bin/flutter-android-emulator
# ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

# terminal setting
RUN wget --progress=dot:giga https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash \
    && wget --progress=dot:giga https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh \
    && chmod a+x ~/.git-completion.bash \
    && chmod a+x ~/.git-prompt.sh \
    && echo -e "\n\
    source ~/.git-completion.bash\n\
    source ~/.git-prompt.sh\n\
    export PS1='\\[\\e]0;\\u@\\h: \\w\\a\\]\${debian_chroot:+(\$debian_chroot)}\\[\\033[01;32m\\]\\u\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\[\\033[1;30m\\]\$(__git_ps1)\\[\\033[0m\\] \\$ '\n\
    " >>  ~/.bashrc

ENV DEBIAN_FRONTEND=

CMD ["/bin/bash"]
