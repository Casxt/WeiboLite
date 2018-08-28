import psycopg2

####################################
#
#生成随机数据
#
####################################
def initRandomUser(num=5000, conn=None, cursor=None):
    """创建测试用户5000个"""

    #存储已经随即出来的用户ID
    userList = list()

    conn,cursor,selfConn = SqlOpen(conn, cursor)
    sql = """INSERT INTO profile ( mail, nickname, introduction, profile_picture, salt, salt_pass ) VALUES (%s,%s,%s,%s,%s,%s) RETURNING id"""
    for i in range(1,num+1):
        print(f"{i} User Inserted") if i%20==0 else None
        cursor.execute(sql, (f"TestUser-{i}@casxt.com", f"TestUser-{i}", f"Introduction", "ProfilePic", "Salt", "SaltPass"))
        userList.append(cursor.fetchone()[0])
    SqlClose(conn,cursor,selfConn)

    return userList

def initRandomWeibo(UsersID, conn=None, cursor=None):
    """创建测试微博10w个，评论100w，采用高斯分布，不保证最后精确数量，但是大于10w基本可以保证"""
    import random

    #存储已经随即出来的微博ID
    weiboList = list()
    #存储已随机出来的评论ID
    commentList = list()
    
    textLib = open("文字素材.txt", "r", encoding='UTF-8')

    def weiboNum():
        """随机一个用户的微博数量,均值20，方差30，超过99%的数据会落在110-0"""
        num = random.gauss(20,30)
        num = 2000 if num > 2000 else num
        return abs(int(num)) if num > -20 else 0

    def weiboType():
        """随机一个用户的微博种类，均值0，方差100，超过99%的数据会落在300~-300"""
        num = random.gauss(0,100)
        if 100 > abs(num) >= 0 or len(weiboList) == 0 or len(commentList) == 0:
            return "NoForward", None
        elif 200 > abs(num) >= 100:
            return "Weibo", weiboList[random.randint(0,len(weiboList)-1)]
        else:
            return "Comment", commentList[random.randint(0,len(commentList)-1)]

    def weiboImg():
        """随机一个用户的微博图片数量，均值0，方差3"""
        s = ""
        r = abs(int(random.gauss(0,3)))
        r = r if r <= 9 else 9
        if r != 0:
            s = "e1a45669df923f6f1b0de326cfc456399019a96373f5912e8cdce5f6291c0a0e"
            for i in range (0,r-1):
                s = s + ",e1a45669df923f6f1b0de326cfc456399019a96373f5912e8cdce5f6291c0a0e"
        return "{%s}"%(s)
    
    def commentNum():
        """随机一个微博的评论数量，均值5，方差20，超过99%的数据会落在65-0"""
        num = random.gauss(5,20)
        num = 2000 if num > 2000 else num
        return abs(int(num)) if num > -20 else 0

    def getContent():
        """随机获取一些文字"""
        return textLib.read(random.randint(10,128))

    conn,cursor,selfConn = SqlOpen(conn, cursor)
    weiboSql = """INSERT INTO weibo ( user_id, content, images, forward_type, forward ) VALUES (%s,%s,%s,%s,%s) RETURNING id"""
    wcommentSql = """INSERT INTO comment ( user_id, weibo_id, comment ) VALUES (%s,%s,%s) RETURNING id"""

    for user in UsersID:
        cursor = conn.cursor()

        #创建微博
        wNum = weiboNum()
        print(f"Create {wNum} Weibo of {user}")
        for i in range(0, wNum):
            forwardType, forward = weiboType()
            cursor.execute(weiboSql, (str(user), getContent(), weiboImg(), forwardType, forward))
            wid = cursor.fetchone()[0]
            weiboList.append(wid)
            #创建评论
            cNum = commentNum()
            print(f"Create {cNum} Comment of Weibo-{wid} of {user}")
            for i in range(0, cNum):
                cursor.execute(wcommentSql, (UsersID[random.randint(0,len(UsersID)-1)], wid, getContent()))

        cursor.close()
        conn.commit()
    conn.close()
    textLib.close()
    return weiboList, commentList

####################################
#
#开关操作
#
####################################      
def SqlOpen(conn = None,cursor = None):
    if conn is None:
        conn = psycopg2.connect(**
        {'host':'localhost',#默认127.0.0.1
        'user':'postgres',
        'password':'753951Qwe',
        'port':5432,#默认即为3306
        'dbname':'WeiboLite',
        })
        cursor = conn.cursor()
        return conn,cursor,True
    else:
        #cursor = conn.cursor()
        return conn,cursor,False

def SqlClose(conn,cursor,selfConn):
    
    if selfConn is True:
        cursor.close()
        conn.commit()
        conn.close()